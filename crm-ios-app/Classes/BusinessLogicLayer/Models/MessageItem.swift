//
//  MessageItem.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 26.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
struct MessageItem: Codable, Identifieble {
    var id: Int
    var body: String
    var senderId: Int
    var receiverId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case senderId = "sender_id"
        case receiverId = "receiver_id"
        case body
    }
}
