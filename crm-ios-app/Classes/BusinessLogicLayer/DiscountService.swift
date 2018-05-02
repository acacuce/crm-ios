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
    
    func fetchAll() -> Observable<[Discount]> {
        let discount = Discount(name: "Test 1", beginDate: Date(), endDate: Date(), scope: .all, type: .count(500), approved: false)
        let discount2 = Discount(name: "Test 2", beginDate: Date(), endDate: Date(), scope: .all, type: .count(500), approved: true)
        
        return Observable.just([discount, discount2])
    }
}
