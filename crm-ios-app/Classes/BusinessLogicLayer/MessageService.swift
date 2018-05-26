//
//  MessageService.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 26.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift

class MessagesService {
    let path = "/messages"
    let transport = NetworkTransport.shared
    
    func fetchAll(from userId: Int, to memberId: Int) -> Observable<[Message]> {
        let translator = UniversalTranslator<[Message]>()
        let full = path
        var request = Request<Message>(path: full, mock: Mock.all)
        request.urlParams = ["from": "\(userId)", "to": "\(memberId)"]
        return transport
            .execute(request: request, translator: translator)
            .observeOn(MainScheduler.instance)
    }
    
    func fetchAll(from userId: Int) -> Observable<[Message]> {
        let translator = UniversalTranslator<[Message]>()
        let full = path
        var request = Request<Message>(path: full, mock: Mock.all)
        request.urlParams = ["from": "\(userId)"]
        return transport
            .execute(request: request, translator: translator)
            .observeOn(MainScheduler.instance)
    }
    
    func fetchAll(to userId: Int) -> Observable<[Message]> {
        let translator = UniversalTranslator<[Message]>()
        let full = path
        var request = Request<Message>(path: full, mock: Mock.all)
        request.urlParams = ["to": "\(userId)"]
        return transport
            .execute(request: request, translator: translator)
            .observeOn(MainScheduler.instance)
    }
    
    func send(_ message: MessageItem) -> Observable<Message> {
        let translator = UniversalTranslator<Message>()
        let full = path
        return transport
            .execute(request: Request<MessageItem>(path: full, mock: Mock.create(message)), translator: translator)
            .observeOn(MainScheduler.instance)
    }
}
