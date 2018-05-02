//
//  SignInViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
class SignInViewController: UIViewController {

    @IBOutlet private var container: UIView!
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var signInButton: UIButton!
    private let disposeBag = DisposeBag()
    private let viewModel = SignInViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        usernameTextField.rx.text
            .filterNil()
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        passwordTextField.rx.text
            .filterNil()
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .bind(onNext: viewModel.signIn)
            .disposed(by: disposeBag)
    }

}
