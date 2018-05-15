//
//  ReportsService.swift
//  crm-ios-app
//
//  Created by Никита Солдатов on 14.05.2018.
//  Copyright © 2018 itis. All rights reserved.
//

import Foundation
import RxSwift

class ReportsService {
    let path = "/reviews"
    let transport = NetworkTransport.shared
    
    func fetchAll(for userId: Int) -> Observable<[Report]> {
        let translator = UniversalTranslator<[Report]>()
        let full = "/users/\(userId)" + path
        return transport
            .execute(request: Request<Report>(path: full, mock: Mock.all), translator: translator)
            .observeOn(MainScheduler.instance)
    }
    
    func send(_ report: Report, for userId: Int) -> Observable<Void> {
        let translator = UniversalTranslator<[Report]>()
        let full = "/users/\(userId)" + path
        return transport
            .execute(request: Request<Report>(path: full, mock: Mock.create(report)))
            .observeOn(MainScheduler.instance)
    }
}
