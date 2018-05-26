//
//  NetworkTransport.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NetworkTransport { 
    let session: URLSession
    static let shared = NetworkTransport()
    init() {
        session = URLSession(configuration: .default)
    }
    
    func execute(request: RequestProtocol) -> Observable<Void> {
        return session.rx
            .data(request: request.makeURLRequest())
            .map { _ in () }
    }
    
    
    func execute<Translator: TranslatorProtocol>(request: RequestProtocol, translator: Translator) -> Observable<Translator.TranslatedValue> {
        
        return session.rx
            .data(request: request.makeURLRequest())
            .map{ (json) -> Translator.TranslatedValue in
                return try translator.translate(json)
            }
            .observeOn(MainScheduler.instance)
    }
}
