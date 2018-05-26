//
//  User.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation


struct User: Identifieble, Codable {
    var id: Int
    var role: Role
    var username: String
    var fullName: String
    var email: String
    var password: String
    let blocked: Bool = false
    var shop: Shop?
    
    enum CodingKeys: String, CodingKey {
        case id
        case role
        case username
        case blocked
        case fullName = "full_name"
        case email
        case password = "password_digest"
        case shop
    }
   
    enum Role: String, Codable {
        case cashier
        case admin
        case manager
    }
}
