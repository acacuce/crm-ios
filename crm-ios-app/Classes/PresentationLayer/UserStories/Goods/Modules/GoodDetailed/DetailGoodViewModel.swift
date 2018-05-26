//
//  DetailGoodViewModel.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift
class DetailGoodViewModel {
    var title = Variable<String>("")
    var name = Variable<String>("")
    var price = Variable<String>("")
    var sizes = Variable<String>("")
    var saveTitle = Variable<String>("")
    var close = PublishSubject<Void>()
    let goodService = GoodsService() 
    private let disposeBag = DisposeBag() 
    var flow: Flow
    
    enum Flow {
        case create
        case update(Good)
    }
    
    init(flow: Flow) {
        self.flow = flow
        switch flow {
        case .create:
            title.value = "Добавить товар"
            saveTitle.value = "Добавить"
        case .update(let good):
            title.value = "Изменить товар"
            saveTitle.value = "Изменить"
            name.value = good.name
            price.value = "\(good.price) руб"
            sizes.value = good.size
        }
    }
    
    func save() {
        guard let priceString = price.value.split(separator: " ").first,
            let price = Double(priceString)
        else {
            return
        }
        let name = self.name.value
        let sizes = self.sizes.value
        
        switch flow {
        case .create:
            let goods = Good(id: 0, name: name, price: price, size: sizes)
            goodService.create(goods)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(())
                .bind(to: close)
                .disposed(by: disposeBag)
            
        case .update(let goods):
            var updatedGoods = goods
            updatedGoods.price = price
            updatedGoods.name = name
            updatedGoods.size = sizes
            
            goodService.update(updatedGoods)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(())
                .bind(to: close)
                .disposed(by: disposeBag)
        }
    }
}
