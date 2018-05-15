//
//  DiscountListViewModel.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift
class DiscountListViewModel {
    var discounts = Variable<[Discount]>([])
    private var recivedDiscounts = Variable<[Discount]>([])
    let discountsService = DiscountService()
    var segmentValue = Variable<Int>(0)
    private let disposeBag = DisposeBag()
    
    init() {
        
        segmentValue.asObservable()
            .flatMap({ (value) -> Observable<[Discount]> in
                let filtred = self.recivedDiscounts.value.filter({ (discount) -> Bool in
                    return (value == 0) ? (discount.approved == false) : (discount.approved == true)
                })
                return Observable.just(filtred)
            })
            .bind(to: discounts)
            .disposed(by: disposeBag)
        
        recivedDiscounts.asObservable()
            .flatMap { (discounts) -> Observable<[Discount]> in
                let filtred = discounts.filter({ (discount) -> Bool in
                    return (self.segmentValue.value == 0) ? (discount.approved == false) : (discount.approved == true)
                })
                return Observable.just(filtred)
            }
            .bind(to: discounts)
            .disposed(by: disposeBag)
    }
    
    func fetchDiscounts() {
        discountsService.fetchAll()
            .catchErrorJustReturn([])
            .bind(to: recivedDiscounts)
            .disposed(by: disposeBag)
    }
}
