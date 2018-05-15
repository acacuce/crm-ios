//
//  Report.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 14.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
struct Report: Codable, Identifieble {
    var id: Int
    var sender: Int
    var reciver: Int
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case sender = "reviewer_id"
        case reciver = "user_id"
        case message = "content"
    }
}
