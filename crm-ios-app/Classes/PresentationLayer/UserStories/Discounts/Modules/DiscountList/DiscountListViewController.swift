//
//  DiscountListViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxOptional
class DiscountListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var statusSegmentControl: UISegmentedControl!
    let viewModel = DiscountListViewModel()
    private let disposeBag = DisposeBag() 
    
    struct Segues {
        static let create = "CreateDiscountSegue"
        static let update = "UpdateDiscountSegue"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset.top += 40
        tableView.tableFooterView = UIView(frame: .zero)
        title = "Скидки"
        bind()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchDiscounts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func bind() {
        viewModel.discounts.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "DiscountCell")) { row, element, cell in
                cell.textLabel?.text = element.name
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d MMM"
                cell.detailTextLabel?.text = "C \(dateFormatter.string(from: element.beginDate)) по \(dateFormatter.string(from: element.endDate))"
            }
            .disposed(by: disposeBag)
        
        statusSegmentControl.rx.value
            .bind(to: viewModel.segmentValue)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let `self` = self else { return }
                let discount = self.viewModel.discounts.value[indexPath.row]
                self.performSegue(withIdentifier: Segues.update, sender: discount)
            }
            .disposed(by: disposeBag)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.create, let destination = segue.destination as? DetailDiscountViewController {
            destination.viewModel = DetailDiscountViewModel(flow: .create)
        } 
        
        if segue.identifier == Segues.update, let destination = segue.destination as? DetailDiscountViewController, let discount = sender as? Discount {
            destination.viewModel = DetailDiscountViewModel(flow: .update(discount))
        } 
    }

}
