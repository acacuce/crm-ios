//
//  UIStoryboardExtensions.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import UIKit
extension UIStoryboard {
    static let auth = { return UIStoryboard.init(name: "Authorization", bundle: .main) }()
    static let shop = { return UIStoryboard.init(name: "Shop", bundle: .main) }()
    static let goods = { return UIStoryboard.init(name: "Goods", bundle: .main) }()
    static let reports = { return UIStoryboard.init(name: "Reports", bundle: .main) }()
    static let accounts = { return UIStoryboard.init(name: "Accounts", bundle: .main) }()
    static let discounts = { return UIStoryboard.init(name: "Discounts", bundle: .main) }()
    static let chat = { return UIStoryboard.init(name: "Chat", bundle: .main) }()
}
