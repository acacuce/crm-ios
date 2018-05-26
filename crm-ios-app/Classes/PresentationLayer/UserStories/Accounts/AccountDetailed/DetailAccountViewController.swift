//
//  DetailGoodViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyPickerPopover
import RxOptional

class DetailAccountViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var statusButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var updateButton: UIButton!
    var viewModel: DetailAccountViewModel!
    private let disposeBag = DisposeBag() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButton.backgroundColor = UIColor(hexString: "#FF9052")
        updateButton.tintColor = .black
        updateButton.layer.cornerRadius = 8.0
        statusButton.rx.tap.bind {
            StringPickerPopover(title: "Выберите роль", choices: [User.Role.admin.rawValue, User.Role.manager.rawValue, User.Role.cashier.rawValue,] )
                .setSelectedRow(0)
                .setDoneButton(action: { (popover, selectedRow, selectedString) in
                    self.statusButton.setTitle(selectedString, for: .normal)
                    self.viewModel.role.value = selectedString
                })
                .setCancelButton(action: { (_, _, _) in 
                })
                .appear(originView: self.statusButton, baseViewController: self)
        }.disposed(by: disposeBag)
        
        
        
        bind()
    }
    
    private func bind() {
        nameTextField.text = viewModel.name.value
        loginTextField.text = viewModel.login.value
        passwordTextField.text = viewModel.password.value
        statusButton.setTitle(viewModel.role.value, for: .normal)
        emailTextField.text = viewModel.email.value
        title = viewModel.title.value
        updateButton.setTitle(viewModel.saveTitle.value, for: .normal)
        
        emailTextField.rx.text
            .filterNil()
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        nameTextField.rx.text
            .filterNil()
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        loginTextField.rx.text
            .filterNil()
            .bind(to: viewModel.login)
            .disposed(by: disposeBag)
        passwordTextField.rx.text
            .filterNil()
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
 
        updateButton.rx.tap
            .bind(onNext: viewModel.save)
            .disposed(by: disposeBag)
        
        viewModel.close
            .bind { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
