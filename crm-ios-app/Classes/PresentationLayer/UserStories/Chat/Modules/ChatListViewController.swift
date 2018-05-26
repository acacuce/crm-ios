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

class ChatListViewController: UIViewController {

    let viewModel = ChatListViewModel()
    let disposeBag = DisposeBag()
    @IBOutlet var tableView: UITableView!
    
    struct Segues {
        static let messages = "ShowMessagesSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "ic_back"))
        title = "Чат"
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

        if segue.identifier == Segues.messages, let destination = segue.destination as? ChatViewController, let account = sender as? User {
            destination.member = account
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
                self.performSegue(withIdentifier: Segues.messages, sender: good)
            }
            .disposed(by: disposeBag)
    }

}
