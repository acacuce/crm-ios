//
//  AuthorizationService.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift
class UserService { 
    let path = "/login"
    let userPath = "/users"
    let transport = NetworkTransport.shared
    func signIn(by username: String, password: String) -> Observable<User> {
        let item = AuthItem(id: 0, username: username, password: password)
        let translatot: UniversalTranslator<User> = UniversalTranslator<User>()
        let request: Request<AuthItem> = Request<AuthItem>.init(path: path, mock: .create(item))
        return transport.execute(request: request, translator: translatot)
    }
    
    func fetchAll() -> Observable<[User]> {
        return transport.execute(request: Request<User>.init(path: userPath, mock: .all), translator: UniversalTranslator<[User]>())
    }
    
    func update(_ user: User) -> Observable<Void> {
        return transport
            .execute(request: Request<User>(path: userPath, mock: Mock.update(user)))
            .observeOn(MainScheduler.instance)
    }
    
    func create(_ user: User) -> Observable<Void> {
        return transport
            .execute(request: Request<User>(path: userPath, mock: Mock.create(user)))
            .observeOn(MainScheduler.instance)
    }
}
