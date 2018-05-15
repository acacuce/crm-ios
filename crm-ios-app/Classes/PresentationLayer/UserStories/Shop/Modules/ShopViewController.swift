//
//  ShopViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 14.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class ShopViewController: BaseChatViewController {
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatDataSource = ShopChatDataSource()
        self.chatItemsDecorator = DemoChatItemsDecorator()
    }
    
    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: DemoTextMessageViewModelBuilder(),
            interactionHandler: DemoTextMessageHandler()
        )
        return [
            "text": [textMessagePresenter],
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
            // Your handling logic
        }
        return item
    }
    
}

