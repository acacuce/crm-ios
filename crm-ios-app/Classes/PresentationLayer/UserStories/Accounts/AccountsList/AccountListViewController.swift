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

class AccountListViewController: UIViewController {

    let viewModel = AccountListViewModel()
    let disposeBag = DisposeBag()
    @IBOutlet var tableView: UITableView!
    
    struct Segues {
        static let create = "CreateUserSegue"
        static let update = "UpdateUserSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "ic_back"))
        title = "Учетнные записи"
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
        if segue.identifier == Segues.create, let destination = segue.destination as? DetailAccountViewController {
            destination.viewModel = DetailAccountViewModel(flow: .create)
        } 
        
        if segue.identifier == Segues.update, let destination = segue.destination as? DetailAccountViewController, let account = sender as? User {
            destination.viewModel = DetailAccountViewModel(flow: .update(account))
        } 
    }

    private func bind() {
        viewModel.accounts.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "AccountCell")) { row, element, cell in
                cell.textLabel?.text = element.fullName
                cell.detailTextLabel?.text = element.role.rawValue
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let `self` = self else { return }
                let good = self.viewModel.accounts.value[indexPath.row]
                self.performSegue(withIdentifier: Segues.update, sender: good)
            }
            .disposed(by: disposeBag)
    }

}
