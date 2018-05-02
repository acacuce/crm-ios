//
//  User.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

struct User {
    var role: Role
    var name: String
    enum Role {
        case manager
        case administrator
        case main
    }
}
