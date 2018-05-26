//
//  GoodsListViewModel.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift
class AccountListViewModel {
    var accounts = Variable<[User]>([])
    let userService = UserService()
    private let disposeBag = DisposeBag()
    
    func fetchGoods() {
        userService.fetchAll()
            .catchErrorJustReturn([])
            .bind(to: accounts)
            .disposed(by: disposeBag)
    }
}
