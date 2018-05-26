//
//  GoodsRequest.swift
//  crm-ios-app
//
//  Created by Наталья on 09.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
protocol Identifieble {
    var id: Int { get }
}

struct Request<Value: Identifieble & Codable>: RequestProtocol {
    init(path: String, mock: Mock<Value>) {
        self.rootPath = path
        self.object = mock
    }
    let rootPath: String
    var object: Mock<Value>
    var path: String {
        return object.path(rootPath: rootPath)
    }
    
    var method: HTTPMethod {
        return object.method
    }
    
    var urlParams: [String: String] = [:]
    
    var parameters: RequestParameters {
        return RequestParameters(jsonBody: object.body, url: urlParams)
    }
    
    var headers: [String : String] {
        return defaultJSONHeaders()
    }
    
    
}

enum Mock<Value: Identifieble & Codable> {
    case all
    case one(id: Int)
    case create(Value)
    case update(Value)
    case delete(Value)

    func path(rootPath: String) -> String {
        let path = rootPath
        switch self {
        case .all: return path
        case .one(let id): return path + "/\(id)"
        case .create(_): return path
        case .update(let value): return path + "/\(value.id)"
        case .delete(let value): return path + "/\(value.id)"
        } 
    }
    
    var method: HTTPMethod {
        switch self {
        case .all: return .get
        case .one(_): return .get
        case .create(_): return .post
        case .update(_): return .patch
        case .delete(_): return .delete
        } 
    }
    
    var body: Data? {
        switch self {
        case .create(let value): return try! UniversalTranslator<Value>().translate(value)
        case .delete(let value): return try! UniversalTranslator<Value>().translate(value)
        case .update(let value): return try! UniversalTranslator<Value>().translate(value)
        default:
            return nil
        }
        
    }
    
}

