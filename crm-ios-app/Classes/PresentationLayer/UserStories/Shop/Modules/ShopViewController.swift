//
//  ShopViewController.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 14.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import Chatto
import SwiftyPickerPopover
import ChattoAdditions
import RxCocoa
import RxSwift

class ShopViewController: BaseChatViewController {
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    var userService = UserService()
    var reviewService = ReviewsService()
    private let disposeBag = DisposeBag() 
    var users = Variable<[User]>([])
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Магазин"
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "ic_back"))
        self.chatDataSource = ShopChatDataSource()
        self.chatItemsDecorator = DemoChatItemsDecorator()
        userService.fetchAll()
            .bind(to: users)
            .disposed(by: disposeBag)
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
            "text": [textMessagePresenter],
            TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()]
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
            StringPickerPopover(title: "Выберите пользователя", choices: self.users.value.map { $0.fullName } )
                .setSelectedRow(0)
                .setDoneButton(action: { (popover, selectedRow, selectedString) in
                    let user = UserDefaults.standard.getUser()!
                    let reviewed = self.users.value[selectedRow]
                    let item = ReviewItem(id: 0, reviewedId: reviewed.id, reviewerId: user.id, content: text)
                    self.reviewService.send(item, for: user.id).subscribe({ (event) in
                        guard let review = event.element else {
                            return
                        }
                        (self.chatDataSource as! ShopChatDataSource).addReviews([review])
                    }).disposed(by: self.disposeBag)
                })
                .setCancelButton(action: { (_, _, _) in 
                    
                })
                .appear(originView: self.inputContainer, baseViewController: self)
        }
        return item
    }
    
}

