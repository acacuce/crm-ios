//
//  Discout.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

struct Discount: Codable, Identifieble {

    enum Scope: String {
        case one
        case all
    }
    
    enum Typo {
        case percent(Double)
        case ammount(Double)
    }
    
    init(id: Int,
         name: String,
         beginDate: Date,
         endDate: Date,
         scope: Scope,
         type: Typo, 
         approved: Bool) {
        self.id = id
        self.name = name
        self.beginDate = beginDate
        self.endDate = endDate
        self.scope = scope
        self.type = type
        self.approved = approved
    }
    
    var id: Int
    var name: String
    var beginDate: Date
    var endDate: Date
    var scope: Scope
    var type: Typo
    var approved: Bool
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case type = "discount_type"
        case value = "value"
        case approved = "approved"
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(approved, forKey: .approved)
        let value: Double
        let type: String
        switch self.type {
        case .ammount(let price): 
            type = "amount"
            value = price
        case .percent(let price):
            type = "percents"
            value = price
        }
        try container.encode(value, forKey: .value)
        try container.encode(type, forKey: .type)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        
        self.name = "Test"
        self.beginDate = Date()
        self.endDate = Date()
        self.scope = .all
        self.approved = try values.decode(Bool.self, forKey: .approved)
        let type = try values.decode(String.self, forKey: .type)
        let value = try values.decode(Double.self, forKey: .value)
        
        if type == "percents" {
            self.type = .percent(value)
        } else if type == "amount" {
            self.type = .ammount(value)
        } else {
            throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: ""))
        }
        
    }
}
