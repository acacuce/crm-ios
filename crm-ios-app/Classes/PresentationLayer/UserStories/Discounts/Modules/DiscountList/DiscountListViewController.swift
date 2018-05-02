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
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
