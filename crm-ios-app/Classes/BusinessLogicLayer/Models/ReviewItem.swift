//
//  ReviewItem.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 26.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

struct ReviewItem: Identifieble, Codable {
    var id: Int
    var reviewedId: Int
    var reviewerId: Int
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case reviewedId = "user_id"
        case reviewerId = "reviewer_id"
        case content = "content"
    }
    
}
