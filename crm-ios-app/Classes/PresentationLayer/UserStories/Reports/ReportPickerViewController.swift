//
//  ReportPickerViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 25.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import UIKit
import RxSwift
class ReportPickerViewController: UIViewController {
    @IBOutlet var begindDateTextFeld: UITextField!
    private let disposeBag = DisposeBag() 
    @IBOutlet var updateButton: UIButton!
    @IBOutlet var endGameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "ic_back"))
        datePicker(to: begindDateTextFeld)
        datePicker(to: endGameTextField)
        updateButton.backgroundColor = UIColor(hexString: "#FF9052")
        updateButton.tintColor = .black
        updateButton.layer.cornerRadius = 8.0

        // Do any additional setup after loading the view.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? ReportViewController else {
            return
        }
        let request = "http://167.99.223.79:3000/v1/reports?from=\(begindDateTextFeld.text ?? "")&to=\(endGameTextField.text ?? "")"
        guard let url = URL(string: request) else {
            return
        }
        
        dest.request = URLRequest(url: url)
        

    }

}
