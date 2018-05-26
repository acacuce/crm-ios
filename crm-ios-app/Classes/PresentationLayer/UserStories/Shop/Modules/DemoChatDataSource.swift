/*
 The MIT License (MIT)

 Copyright (c) 2015-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

import Foundation
import Chatto
import ChattoAdditions
import RxSwift

class ShopChatDataSource: ChatDataSourceProtocol {
    var nextMessageId: Int = 0
    let preferredMaxWindowSize = 500
    let reportService = ReviewsService()
    private let disposeBag = DisposeBag() 
    init() {
        let user = UserDefaults.standard.getUser()!
        reportService.fetchAll(for: user.id).subscribe { (event) in
            guard let reports = event.element else {
                return
            }
            self.addReviews(reports)
            
        }.disposed(by: disposeBag)
    }
    
    func addReviews(_ reviews: [Review]) {
        let user = UserDefaults.standard.getUser()!
        let messages = reviews.map { report in
            return DemoTextMessageModel(messageModel: MessageModel(uid: "\(report.id)", senderId: "\(report.sender.id)", type: "text", isIncoming: report.sender.id != user.id, date: Date(), status: .success), text: report.message, user: report.sender)
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
