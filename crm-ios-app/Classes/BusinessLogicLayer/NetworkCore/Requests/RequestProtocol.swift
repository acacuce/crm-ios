//
//  RequestProtocol.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var host: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: RequestParameters {get}
    var headers: [String: String] {get}
    var isProtected: Bool {get}
    
}

public enum HTTPMethod: String {
    case post
    case put
    case delete
    case get
    case patch
}

public struct RequestParameters {
    var jsonBody: [String: Any] = [:]
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
        urlComponents.scheme = "http"
        urlComponents.host = host
        
        let queryItems = parameters.url.map { return URLQueryItem(name: $0, value: $1) }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            fatalError("Can't construct url")
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue.uppercased()
        let json = parameters.jsonBody
        if !json.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [])
        }
        return request
    }
}
