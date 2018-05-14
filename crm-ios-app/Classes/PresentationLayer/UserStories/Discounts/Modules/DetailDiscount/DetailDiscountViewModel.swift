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
    var flow: Flow
    
    let dateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        return formatter
    }()

    enum Flow {
        case create
        case update(Discount)
    }

    init(flow: Flow) {
        self.flow = flow
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
            case .count(let value):
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
        close.onNext(())
    }


}
