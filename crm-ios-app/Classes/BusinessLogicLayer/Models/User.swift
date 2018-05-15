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
    var shop: Shop?
   
    enum Role: String, Codable {
        case manager
        case administrator
        case main
    }
}
