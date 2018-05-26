//
//  DetailDiscountViewModel.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift

class DetailDiscountViewModel {
    var title = Variable<String>("")
    var name = Variable<String>("")
    var beginDate = Variable<String>("")
    var endDate = Variable<String>("")
    var scopeOneEnable = Variable<Bool>(false)
    var scopeAllEnable = Variable<Bool>(false)
    var percentEnable = Variable<Bool>(false)
    var percent = Variable<String>("")
    var countEnable = Variable<Bool>(false)
    var count = Variable<String>("")
    var saveTitle = Variable<String>("")
    var close = PublishSubject<Void>()
    var selectedGood: Good?
    var goods = Variable<[Good]>([])
    let goodService = GoodsService()
    var flow: Flow
    private let disposeBag = DisposeBag() 
    
    let discountService = DiscountService()
    
    let dateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    enum Flow {
        case create
        case update(Discount)
    }

    init(flow: Flow) {
        self.flow = flow
        goodService.fetchGoods().bind(to: goods).disposed(by: disposeBag)
        switch flow {
        case .create:
            title.value = "Добавить скидку"
            saveTitle.value = "Добавить"
        case .update(let discount):
            title.value = "Изменить скидку"
            saveTitle.value = "Изменить"
            name.value = discount.name
            beginDate.value =  dateFormatter.string(from: discount.beginDate )
            endDate.value = dateFormatter.string(from: discount.endDate)

            switch discount.scope {
            case .all:
                scopeAllEnable.value = true
                scopeOneEnable.value = false
            case .one:
                scopeAllEnable.value = false
                scopeOneEnable.value = true
            }

            switch discount.type {
            case .ammount(let value):
                countEnable.value = true
                percentEnable.value = false
                count.value = String(value)
            case .percent(let value):
                percentEnable.value = true
                countEnable.value = false
                percent.value = String(value)
            }
        }
    }

    func save() {
        let name = self.name.value
        guard let begin = dateFormatter.date(from: beginDate.value),
            let end = dateFormatter.date(from: endDate.value) 
        else { 
            return
        } 
        
        let scope = (scopeAllEnable.value == true) ? Discount.Scope.all : Discount.Scope.one
        guard let goodId = selectedGood?.id else {
            return
        }
        
        
        let type: Discount.Typo
        if percentEnable.value == true, let percent = Double(percent.value), 0...100 ~= percent {
            type = .percent(percent)
        } else if countEnable.value == true, let value = Double(count.value) {
            type = .ammount(value)
        } else {
            return
        }
        
        switch flow {
        case .create:
            var discount = Discount(id: 0, name: name, beginDate: begin, endDate: end, scope: scope, type: type, approved: false)
            discount.goodId = goodId
            discountService.create(discount)
                .catchErrorJustReturn(())
                .bind(to: close)
                .disposed(by: disposeBag)
        case .update(let discount):
            var newDiscount = Discount(id: discount.id, name: name, beginDate: begin, endDate: end, scope: scope, type: type, approved: discount.approved)
            newDiscount.goodId = goodId
            discountService.update(newDiscount)
                .catchErrorJustReturn(())
                .bind(to: close)
                .disposed(by: disposeBag)
        }
        
        close.onNext(())
    }


}
