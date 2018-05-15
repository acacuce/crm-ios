//
//  Good.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

struct Good: Codable, Identifieble {
    var id: Int
    var name: String
    var price: Double
    var size: String
    
    enum CodingKeys: String, CodingKey {
        case size = "kind"
        case id
        case name
        case price
        
    }
}
