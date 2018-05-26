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
        
        func name() -> String {
            switch self {
            case .percent(let value):
                return "\(value) %"
            case .ammount(let value):
                return "\(value) руб."
            }
        }
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
    var goodId: Int?
    var name: String
    var beginDate: Date
    var endDate: Date
    var scope: Scope
    var type: Typo
    var approved: Bool
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case goodId = "good_id"
        case type = "discount_type"
        case value = "value"
        case approved = "approved"
        case begin = "valid_from"
        case end = "valid_to"
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        if case .one = self.scope {
            try container.encode(goodId, forKey: .goodId)
        }
        
        try container.encode(approved, forKey: .approved)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.'SSSZ"
        try container.encode(dateFormatter.string(from: beginDate), forKey: .begin)
        try container.encode(dateFormatter.string(from: endDate), forKey: .end)
        
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.'SSSZ"
        let beginString = try values.decode(String.self, forKey: .begin)
        let endString = try values.decode(String.self, forKey: .end)
        self.beginDate = dateFormatter.date(from: beginString)!
        self.endDate = dateFormatter.date(from: endString)!
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
        self.name = "Скидка \(self.type.name())"
        
    }
}
