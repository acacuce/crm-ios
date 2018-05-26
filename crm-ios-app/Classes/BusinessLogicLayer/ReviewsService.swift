//
//  ReportsService.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 14.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift

class ReviewsService {
    let path = "/reviews"
    let transport = NetworkTransport.shared
    
    func fetchAll(for userId: Int) -> Observable<[Review]> {
        let translator = UniversalTranslator<[Review]>()
        let full = "/users/\(userId)" + path
        return transport
            .execute(request: Request<Review>(path: full, mock: Mock.all), translator: translator)
            .observeOn(MainScheduler.instance)
    }
    
    func send(_ report: ReviewItem, for userId: Int) -> Observable<Review> {
        let translator = UniversalTranslator<Review>()
        let full = "/users/\(userId)" + path
        return transport
            .execute(request: Request<ReviewItem>(path: full, mock: Mock.create(report)), translator: translator)
            .observeOn(MainScheduler.instance)
    }
}
