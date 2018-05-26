//
//  TabBarViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configure(with role: User.Role) {
        guard 
            let shop = UIStoryboard.shop.instantiateInitialViewController(),
            let goods = UIStoryboard.goods.instantiateInitialViewController(),
            let reports = UIStoryboard.reports.instantiateInitialViewController(),
            let accounts = UIStoryboard.accounts.instantiateInitialViewController(),
            let discounts = UIStoryboard.discounts.instantiateInitialViewController(),
            let chat = UIStoryboard.chat.instantiateInitialViewController()
        else { fatalError("Can't load controllers") } 
        shop.tabBarItem = UITabBarItem(title: "Главная", image: nil, selectedImage: nil)
        goods.tabBarItem = UITabBarItem(title: "Товары", image: nil, selectedImage: nil)
        reports.tabBarItem = UITabBarItem(title: "Отчеты", image: nil, selectedImage: nil)
        accounts.tabBarItem = UITabBarItem(title: "Учетные записи", image: nil, selectedImage: nil)
        discounts.tabBarItem = UITabBarItem(title: "Скидки", image: nil, selectedImage: nil)
        chat.tabBarItem = UITabBarItem(title: "Чат", image: nil, selectedImage: nil)
        switch role {
        case .admin:
            setViewControllers([shop, chat, discounts, accounts, reports, goods], animated: false)
        case .cashier:
            setViewControllers([shop, chat], animated: false)
        case .manager: 
            setViewControllers([shop, chat, discounts, accounts, reports], animated: false)
        
        }
        
        
    }
}
