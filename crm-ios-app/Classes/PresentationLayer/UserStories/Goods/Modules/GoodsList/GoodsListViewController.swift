//
//  GoodsListViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GoodsListViewController: UIViewController {

    let viewModel = GoodsListViewModel()
    let disposeBag = DisposeBag()
    @IBOutlet var tableView: UITableView!
    
    struct Segues {
        static let create = "CreateGoodSegue"
        static let update = "UpdateGoodSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "ic_back"))
        title = "Товары"
        bind()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundView = nil
        tableView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchGoods()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.create, let destination = segue.destination as? DetailGoodViewController {
            destination.viewModel = DetailGoodViewModel(flow: .create)
        } 
        
        if segue.identifier == Segues.update, let destination = segue.destination as? DetailGoodViewController, let good = sender as? Good {
            destination.viewModel = DetailGoodViewModel(flow: .update(good))
        } 
    }

    private func bind() {
        viewModel.goods.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "GoodCell")) { row, element, cell in
                cell.textLabel?.text = element.name
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let `self` = self else { return }
                let good = self.viewModel.goods.value[indexPath.row]
                self.performSegue(withIdentifier: Segues.update, sender: good)
            }
            .disposed(by: disposeBag)
    }

}
