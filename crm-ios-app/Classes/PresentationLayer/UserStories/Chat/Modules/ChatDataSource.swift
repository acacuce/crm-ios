//
//  ChatDataSource.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 26.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//


import Foundation
import Chatto
import ChattoAdditions
import RxSwift

class ChatDataSource: ChatDataSourceProtocol {
    var nextMessageId: Int = 0
    let preferredMaxWindowSize = 500
    let messagesService = MessagesService()
    private let disposeBag = DisposeBag() 
    init(member: User) {
        let user = UserDefaults.standard.getUser()!
        let result = RxSwift.Observable
            .zip(messagesService.fetchAll(from: user.id, to: member.id),
                 messagesService.fetchAll(from: member.id, to: user.id)) { value, value2 -> [Message] in
                    var messages = value
                    messages.append(contentsOf: value2)
                    return messages
            }
        
        result.bind(onNext: addMessages(_:)).disposed(by: disposeBag)
    }
    func addMessages(_ messages: [Message]) {
        let user = UserDefaults.standard.getUser()!
        let messages = messages.map { report in
            return DemoTextMessageModel(messageModel: MessageModel(uid: "\(report.id)", senderId: "\(report.sender.id)", type: "text", isIncoming: report.sender.id != user.id, date: Date(), status: .success), text: report.body, user: report.sender)
        }
        self.chatItems.append(contentsOf: messages)
        self.delegate?.chatDataSourceDidUpdate(self, updateType: .normal)
    }
    
    var hasMoreNext: Bool {
        return false
    }
    
    var hasMorePrevious: Bool {
        return false
    }
    
    var chatItems: [ChatItemProtocol] = []
    
    weak var delegate: ChatDataSourceDelegateProtocol?
    
    func loadNext() {
        
    }
    
    func loadPrevious() {
        
    }
    
    
    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion:(_ didAdjust: Bool) -> Void) {
        
        completion(false)
    }
}
