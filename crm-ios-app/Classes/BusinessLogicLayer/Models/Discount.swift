//
//  Discout.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

struct Discount {
    enum Scope {
        case one
        case all
    }
    
    enum `Type` {
        case percent(Double)
        case count(Double)
    }
    
    var name: String
    var beginDate: Date
    var endDate: Date
    var scope: Scope
    var type: Type
    var approved: Bool
}
