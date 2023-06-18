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
    public let moitID: String
    public let moitName: String
    public let masterID: String
    public let description: String?
    public let imageURL: String
    public let scheduleDescription: String
    public let ruleShortDescription: String
    public let ruleLoneDescription: String
    public let periodDescription: String
    
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
