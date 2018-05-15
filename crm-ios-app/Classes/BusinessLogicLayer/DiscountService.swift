//
//  DiscountService.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift
class DiscountService {
    let path = "/discounts"
    let transport = NetworkTransport.shared
    
    func fetchAll() -> Observable<[Discount]> {
        let translator = UniversalTranslator<[Discount]>()
        return transport
            .execute(request: Request<Discount>(path: path, mock: Mock.all), translator: translator)
            .observeOn(MainScheduler.instance)
    }
    
    func update(_ discount: Discount) -> Observable<Void> {
        return transport
            .execute(request: Request<Discount>(path: path, mock: Mock.update(discount)))
            .observeOn(MainScheduler.instance)
    }
    
    func create(_ discount: Discount) -> Observable<Void> {
        return transport
            .execute(request: Request<Discount>(path: path, mock: Mock.create(discount)))
            .observeOn(MainScheduler.instance)
    }
}
