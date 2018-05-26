//
//  DetailGoodViewModel.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 02.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift
class DetailAccountViewModel {
    var title = Variable<String>("")
    var name = Variable<String>("")
    var email = Variable<String>("")
    var password = Variable<String>("")
    var login = Variable<String>("")
    var role = Variable<String>("")
    var saveTitle = Variable<String>("")
    var close = PublishSubject<Void>()
    let userService = UserService() 
    private let disposeBag = DisposeBag() 
    var flow: Flow
    
    enum Flow {
        case create
        case update(User)
    }
    
    init(flow: Flow) {
        self.flow = flow
        switch flow {
        case .create:
            title.value = "Добавить аккаунт"
            saveTitle.value = "Добавить"
            role.value = "Статус"
        case .update(let user):
            title.value = "Изменить аккаунт"
            saveTitle.value = "Изменить"
            name.value = user.fullName
            email.value = user.email
            login.value = user.username
            password.value = user.password
            role.value = user.role.rawValue
        }
    }
    
    func save() {
        let roleString = self.role.value
        guard let role = User.Role.init(rawValue: roleString) else {
            return
        }
        let name = self.name.value
        let login = self.login.value
        let password = self.password.value
        let email = self.email.value
        
        
        switch flow {
        case .create:
            let account = User(id: 0, role: role, username: login, fullName: name, email: email, password: password, shop: nil)
            userService.create(account)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(())
                .bind(to: close)
                .disposed(by: disposeBag)
            
        case .update(let user):
            var updatedUser = user
           updatedUser.role = role
           updatedUser.fullName = name
           updatedUser.password = password
            updatedUser.email = email
           updatedUser.username = login
            userService.update(updatedUser)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(())
                .bind(to: close)
                .disposed(by: disposeBag)
            
        }
    }
}
