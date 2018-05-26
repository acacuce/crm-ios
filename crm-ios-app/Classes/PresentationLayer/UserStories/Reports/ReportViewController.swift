//
//  ReportViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 25.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import UIKit
import WebKit
class ReportViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    var request: URLRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(request)
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
