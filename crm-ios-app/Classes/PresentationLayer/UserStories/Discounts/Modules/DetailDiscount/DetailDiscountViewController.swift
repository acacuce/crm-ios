//
//  DetailDiscountViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import UIKit
import SwiftyPickerPopover
import LTHRadioButton
import RxSwift
import RxCocoa
import RxOptional

class DetailDiscountViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var beginDateTextField: UITextField!
    @IBOutlet var endDateTextField: UITextField!
    
    @IBOutlet var percentTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var scopOneRadioButton: LTHRadioButton!
    @IBOutlet var scopeAllRadioButton: LTHRadioButton!
    @IBOutlet var typePercentRadioButton: LTHRadioButton!
    @IBOutlet var typeMoneyRadioButton: LTHRadioButton!
    var viewModel: DetailDiscountViewModel!
     private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.backgroundColor = UIColor(hexString: "#FF9052")
        saveButton.tintColor = .black
        saveButton.layer.cornerRadius = 8.0
        datePicker(to: beginDateTextField)
        datePicker(to: endDateTextField)
        scopOneRadioButton.onSelect { [weak self] in
            guard let `self` = self else { return }
            StringPickerPopover(title: "Выберите товар", choices: self.viewModel.goods.value.map { $0.name } )
                .setSelectedRow(0)
                .setDoneButton(action: { (popover, selectedRow, selectedString) in
                    self.viewModel.selectedGood = self.viewModel.goods.value[selectedRow]
                    self.scopeAllRadioButton.deselect()
                    self.viewModel.scopeAllEnable.value = false
                    self.viewModel.scopeOneEnable.value = true
                })
                .setCancelButton(action: { (_, _, _) in 
                    self.scopOneRadioButton.deselect()
                })
                .appear(originView: self.scopOneRadioButton, baseViewController: self)
         
        }
        
        scopeAllRadioButton.onSelect { [weak self] in
            self?.scopOneRadioButton.deselect()
            self?.viewModel.scopeAllEnable.value = true
            self?.viewModel.scopeOneEnable.value = false
        }
        
        typePercentRadioButton.onSelect { [weak self] in
            self?.typeMoneyRadioButton.deselect()
            self?.viewModel.percentEnable.value = true
            self?.viewModel.countEnable.value = false
        }
        
        typeMoneyRadioButton.onSelect { [weak self] in
            self?.typePercentRadioButton.deselect()
            self?.viewModel.percentEnable.value = false
            self?.viewModel.countEnable.value = true
        }
        bind()
    }
    
    func datePicker(to textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        datePicker.rx.value
            .map { (date) -> String in
                dateFormatter.string(from: date)
            }
            .bind(to: textField.rx.text)
            .disposed(by: disposeBag)
        
        textField.inputView = datePicker
    }


    private func bind() {
        nameTextField.text = viewModel.name.value
        beginDateTextField.text = viewModel.beginDate.value
        endDateTextField.text = viewModel.endDate.value
        percentTextField.text = viewModel.percent.value
        priceTextField.text = viewModel.count.value
        saveButton.setTitle(viewModel.saveTitle.value, for: .normal)
        updateRadioButton(scopOneRadioButton, with: viewModel.scopeOneEnable.value)
        updateRadioButton(scopeAllRadioButton, with: viewModel.scopeAllEnable.value)
        updateRadioButton(typeMoneyRadioButton, with: viewModel.countEnable.value)
        updateRadioButton(typePercentRadioButton, with: viewModel.percentEnable.value)

        nameTextField.rx.text
            .filterNil()
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        beginDateTextField.rx.text
            .filterNil()
            .bind(to: viewModel.beginDate)
            .disposed(by: disposeBag)
        endDateTextField.rx.text
            .filterNil()
            .bind(to: viewModel.endDate)
            .disposed(by: disposeBag)
        percentTextField.rx.text
            .filterNil()
            .bind(to: viewModel.percent)
            .disposed(by: disposeBag)
        priceTextField.rx.text
            .filterNil()
            .bind(to: viewModel.count)
            .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .bind(onNext: viewModel.save)
            .disposed(by: disposeBag)

        viewModel.close
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    private func updateRadioButton(_ button: LTHRadioButton, with state: Bool) {
        if state {
            button.select()
        } else {
            button.deselect()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
