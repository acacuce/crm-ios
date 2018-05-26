//
//  AppDelegate.swift
//  crm-ios-app
//
//  Created by Наталья on 24.04.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwifterSwift
extension UserDefaults {
    func saveUser(_ user: User) {
        let encoder = JSONEncoder.init()
        let data = try! encoder.encode(user)
        setValue(data, forKey: "user")
    }
    
    func getUser() -> User? {
        guard let data = value(forKey: "user") as? Data else {
            return nil
        }
        let decoder = JSONDecoder.init()
        let user = try! decoder.decode(User.self, from: data) 
        return user
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let rootController: UIViewController
        if let user = UserDefaults.standard.getUser() {
            let rootController = TabBarController()
            rootController.configure(with: user.role)
            window?.rootViewController = rootController
        } else {
            window?.rootViewController = UIStoryboard.auth.instantiateInitialViewController()
        }
        UITabBar.appearance().barTintColor = UIColor(hexString: "#D7C5BB") 
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor(hexString: "#8190A5") 
        UINavigationBar.appearance().barTintColor = UIColor(hexString: "#D7C5BB") 
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

