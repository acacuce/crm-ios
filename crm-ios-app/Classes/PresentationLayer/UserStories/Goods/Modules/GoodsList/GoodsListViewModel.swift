//
//  GoodsListViewModel.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift
class GoodsListViewModel {
    var goods = Variable<[Good]>([])
    let goodsService = GoodsService()
    private let disposeBag = DisposeBag()
    
    func fetchGoods() {
        goodsService.fetchGoods()
            .catchErrorJustReturn([])
            .bind(to: goods)
            .disposed(by: disposeBag)
    }
}
