//
//  Good.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

struct Good {
    var name: String
    var price: Float
    var size: String

    init(name: String, price: Float, size: String) {
        self.name = name
        self.price = price
        self.size = size
    }
}
