//
//  Report.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 14.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
struct Review: Codable, Identifieble {
    var id: Int
    var sender: User
    var reciver: User
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case sender = "reviewer"
        case reciver = "reviewed_user"
        case message = "content"
    }
}
