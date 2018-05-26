//
//  Message.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 26.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

struct Message: Codable, Identifieble {
    var id: Int
    var body: String
    var sender: User
    var receiver: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case sender
        case receiver
        case body
    }
    
}
