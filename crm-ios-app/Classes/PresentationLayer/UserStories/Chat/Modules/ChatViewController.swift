//
//  ChatViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 26.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import Chatto
import SwiftyPickerPopover
import ChattoAdditions
import RxCocoa
import RxSwift

class ChatViewController: BaseChatViewController {
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    var userService = UserService()
    var messageService = MessagesService()
    var member: User!
    
    private let disposeBag = DisposeBag() 
    override func viewDidLoad() {
        super.viewDidLoad()
        title = member.fullName
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "ic_back"))
        self.chatDataSource = ChatDataSource(member: member)
        self.chatItemsDecorator = DemoChatItemsDecorator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IQKeyboardManager.shared.enable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
    }
    
    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: DemoTextMessageViewModelBuilder(),
            interactionHandler: DemoTextMessageHandler()
        )
        return [
            "text": [textMessagePresenter]
        ]
    }
    
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        chatInputView.maxCharactersCount = 1000
        return chatInputView
    }
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        return items
    }
    
    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            guard let `self` = self else { return }
            let user = UserDefaults.standard.getUser()!
            let reviewed = self.member!
            let item = MessageItem(id: 0, body: text, senderId: user.id, receiverId: reviewed.id)
            self.messageService.send(item).subscribe({ (event ) in
                guard let review = event.element else {
                    return
                }
                
                (self.chatDataSource as! ChatDataSource).addMessages([review])
            }).disposed(by: self.disposeBag)

        }
        return item
    }
    
}
