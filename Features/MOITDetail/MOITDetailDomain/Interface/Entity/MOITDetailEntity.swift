//
//  MOITDetailEntity.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOITDetailEntity {
    public let moitID: String
    public let moitName: String
    public let masterID: String
    public let description: String?
    public let imageURL: String?
    public let scheduleDescription: String
    public let ruleShortDescription: String
    public let ruleLongDescription: String
	public let isNotificationActive: Bool
	public let notificationDescription: String
    public let periodDescription: String
    public let invitationCode: String
    
    public init(
        moitID: String,
        moitName: String,
        masterID: String,
        description: String?,
        imageURL: String?,
        scheduleDescription: String,
        ruleShortDescription: String,
        ruleLoneDescription: String,
        periodDescription: String,
        invitationCode: String,
		isNotificationActive: Bool,
		notificationDescription: String
    ) {
        self.invitationCode = invitationCode
        self.moitID = moitID
        self.moitName = moitName
        self.masterID = masterID
        self.description = description
        self.imageURL = imageURL
        self.scheduleDescription = scheduleDescription
        self.ruleShortDescription = ruleShortDescription
        self.ruleLongDescription = ruleLoneDescription
		self.isNotificationActive = isNotificationActive
		self.notificationDescription = notificationDescription
        self.periodDescription = periodDescription
    }
}
