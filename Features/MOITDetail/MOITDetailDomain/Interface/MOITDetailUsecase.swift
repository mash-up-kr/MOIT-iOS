//
//  MOITDetailUsecase.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RxSwift

public struct MOITDetailEntity {
    let moitID: String
    let moitName: String
    let masterID: String
    let description: String?
    let imageURL: String
    let scheduleDescription: String
    let ruleShortDescription: String
    let ruleLoneDescription: String
    let periodDescription: String
    
    public init(moitID: String, moitName: String, masterID: String, description: String?, imageURL: String, scheduleDescription: String, ruleShortDescription: String, ruleLoneDescription: String, periodDescription: String) {
        self.moitID = moitID
        self.moitName = moitName
        self.masterID = masterID
        self.description = description
        self.imageURL = imageURL
        self.scheduleDescription = scheduleDescription
        self.ruleShortDescription = ruleShortDescription
        self.ruleLoneDescription = ruleLoneDescription
        self.periodDescription = periodDescription
    }
}

public protocol MOITDetailUsecase {
    func moitDetail(with ID: String) -> Single<MOITDetailEntity>
}
