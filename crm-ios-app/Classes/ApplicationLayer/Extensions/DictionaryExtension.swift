//
//  DictionaryExtension.swift
//  crm-ios-app
//
//  Created by Наталья on 09.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

enum GetValueWithCastError: Error {
    case valueNotExist(String)
    case castFailed(String)

    var localizedDescription: String {
        switch self {
        case let .valueNotExist(message),
             let .castFailed(message):
            return message
        }
    }
}

extension Dictionary {

    func getValueWithCast<ValueType>(key: Key) throws -> ValueType {
        guard let value = self[key] else {
            throw GetValueWithCastError.valueNotExist("Value for key \(key) doesn't exist")
        }
        guard let castedValue = value as? ValueType else {
            throw GetValueWithCastError.castFailed("Failed cast value for key \(key) to type \(ValueType.self)")
        }
        return castedValue
    }

}
