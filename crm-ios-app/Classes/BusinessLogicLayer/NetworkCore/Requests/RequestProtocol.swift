//
//  RequestProtocol.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: RequestParameters {get}
    var headers: [String: String] {get}
    
}

public enum HTTPMethod: String {
    case post
    case put
    case delete
    case get
    case patch
}

public struct RequestParameters {
    var jsonBody: Data?
    var url: [String: String] = [:]
}

extension RequestProtocol {
    func defaultJSONHeaders() -> [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    func defaultAPIPath() -> String {
        return "/api/v1"
    }
    
    func makeURLRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = Enviroment.protocol
        urlComponents.host = Enviroment.host
        urlComponents.port = Enviroment.port
        
        urlComponents.path = "/" + Enviroment.version + path
        let queryItems = parameters.url.map { return URLQueryItem(name: $0, value: $1) }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            fatalError("Can't construct url")
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue.uppercased()
        if let json = parameters.jsonBody {
            request.httpBody = json
        }
        return request
    }
}
