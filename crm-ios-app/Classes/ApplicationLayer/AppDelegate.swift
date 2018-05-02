//
//  AppDelegate.swift
//  crm-ios-app
//
//  Created by Наталья on 24.04.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        // Override point for customization after application launch.
        return true
    }
}

