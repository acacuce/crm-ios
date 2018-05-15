//
//  GoodsService.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift

class Enviroment {
    static let `protocol` = "http" 
    static let port = 3000
    static let version = "v1"
    static let host = "167.99.223.79"
}

class GoodsService {
    let rootPath: String = "/goods" 
    let transport = NetworkTransport.shared
    func fetchGoods() -> Observable<[Good]> {
        return transport.execute(request: Request<Good>(path: rootPath, mock: Mock.all), translator: UniversalTranslator<[Good]>())
    }
    
    func create(_ goods: Good) -> Observable<Void> {
        return transport.execute(
            request: Request<Good>(
                path: rootPath,
                mock: Mock.create(goods)
            )
        )
    }
}
