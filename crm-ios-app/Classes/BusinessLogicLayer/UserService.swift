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
        
    func signIn(by username: String, password: String) -> Observable<User> {
        return Observable.just(User(role: .main, name: "Test"))
    }
}
