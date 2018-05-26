//
//  AuthItem.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 21.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
struct AuthItem: Identifieble, Codable {
    var id: Int
    var username: String
    var password: String
}
