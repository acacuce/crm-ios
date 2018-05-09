//
//  TranslatorProtocol.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

protocol TranslatorProtocol {
    associatedtype TranslatedValue
    func translate(_ json: [String: Any]) throws -> TranslatedValue
}

