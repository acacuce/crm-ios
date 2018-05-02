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
import RxOptional

class DetailGoodViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var sizesTextField: UITextField!
    @IBOutlet var updateButton: UIButton!
    var viewModel: DetailGoodViewModel!
    private let disposeBag = DisposeBag() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        nameTextField.text = viewModel.name.value
        priceTextField.text = viewModel.price.value
        sizesTextField.text = viewModel.sizes.value
        title = viewModel.title.value
        updateButton.setTitle(viewModel.saveTitle.value, for: .normal)
        
        nameTextField.rx.text
            .filterNil()
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        priceTextField.rx.text
            .filterNil()
            .bind(to: viewModel.price)
            .disposed(by: disposeBag)
        sizesTextField.rx.text
            .filterNil()
            .bind(to: viewModel.sizes)
            .disposed(by: disposeBag)
        updateButton.rx.tap
            .bind(onNext: viewModel.save)
            .disposed(by: disposeBag)
    }
    
}
