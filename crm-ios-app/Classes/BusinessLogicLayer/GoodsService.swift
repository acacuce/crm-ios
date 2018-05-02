//
//  GoodsService.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift
class GoodsService {
    
    func fetchGoods() -> Observable<[Good]> {
        return Observable.just([Good(name: "Test", price: 300.0, sizes: "L, XL")])
    }
}
