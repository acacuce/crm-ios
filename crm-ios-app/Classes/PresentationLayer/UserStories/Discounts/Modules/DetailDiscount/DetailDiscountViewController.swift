//
//  DetailDiscountViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import UIKit
import LTHRadioButton
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scopOneRadioButton.onSelect { [weak self] in
            self?.scopeAllRadioButton.deselect()
        }
        
        scopeAllRadioButton.onSelect { [weak self] in
            self?.scopOneRadioButton.deselect()
        }
        
        typePercentRadioButton.onSelect { [weak self] in
            self?.typeMoneyRadioButton.deselect()
        }
        
        typeMoneyRadioButton.onSelect { [weak self] in
            self?.typePercentRadioButton.deselect()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
