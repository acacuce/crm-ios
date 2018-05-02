//
//  SignInViewModel.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 01.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel {
    var username = Variable<String>("") 
    var password = Variable<String>("")
    var isLoading = PublishSubject<Bool>()
    let userService = UserService() 
    
    func signIn() {
        isLoading.onNext(true)
        userService.signIn(by: username.value, password: password.value).subscribe { (event) in
            self.isLoading.onNext(false)
            guard let user = event.element else {
                return
            }
            
            
        }
    }
    
}
