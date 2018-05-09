//
//  GoodsTranslator.swift
//  crm-ios-app
//
//  Created by Наталья on 09.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

class GoodsTranslator: TranslatorProtocol {

    enum GoodsKeys: String {
        case name
        case price
        case kind
    }

    func translate(_ json: [String: Any]) throws -> Good {
        return Good(name: try json.getValueWithCast(key: GoodsKeys.name.rawValue), price: try json.getValueWithCast(key: GoodsKeys.price.rawValue), size: try json.getValueWithCast(key: GoodsKeys.kind.rawValue))
    }
}
