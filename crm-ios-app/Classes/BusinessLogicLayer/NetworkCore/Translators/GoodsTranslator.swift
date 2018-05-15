//
//  GoodsTranslator.swift
//  crm-ios-app
//
//  Created by Наталья on 09.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

class UniversalTranslator<Object: Codable>: TranslatorProtocol {
    typealias TranslatedValue = Object
    func translate(_ json: Data) throws -> TranslatedValue {
        return try JSONDecoder().decode(TranslatedValue.self, from: json)
    }
    
    func translate(_ value: TranslatedValue) throws -> Data {
        return try JSONEncoder().encode(value)
    }
}

