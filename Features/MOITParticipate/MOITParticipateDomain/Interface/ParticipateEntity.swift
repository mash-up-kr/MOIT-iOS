//
//  ParticipateEntity.swift
//  MOITParticipateDomain
//
//  Created by 최혜린 on 2023/08/04.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct ParticipateEntity {
	public let moitID: Int
	public let moitName: String
	public let description: String
	public let imageURL: String?
	public let scheduleDayOfWeeks: [String]
	public let scheduleRepeatCycle: String
	public let scheduleStartTime: String
	public let scheduleEndTime: String
	public let fineLateTime: Int
	public let fineLateAmount: Int
	public let fineAbsenceTime: Int
	public let fineAbsenceAmount: Int
	public let isRemindActive: Bool
	public let notificationRemindOption: String
	public let startDate: String
	public let endDate: String
	
	public init(
		moitID: Int,
		moitName: String,
		description: String,
		imageURL: String?,
		scheduleDayOfWeeks: [String],
		scheduleRepeatCycle: String,
		scheduleStartTime: String,
		scheduleEndTime: String,
		fineLateTime: Int,
		fineLateAmount: Int,
		fineAbsenceTime: Int,
		fineAbsenceAmount: Int,
		notificationIsRemindActive: Bool,
		notificationRemindOption: String,
		startDate: String,
		endDate: String
	) {
		self.moitID = moitID
		self.moitName = moitName
		self.description = description
		self.imageURL = imageURL
		self.scheduleDayOfWeeks = scheduleDayOfWeeks
		self.scheduleRepeatCycle = scheduleRepeatCycle
		self.scheduleStartTime = scheduleStartTime
		self.scheduleEndTime = scheduleEndTime
		self.fineLateTime = fineLateTime
		self.fineLateAmount = fineLateAmount
		self.fineAbsenceTime = fineAbsenceTime
		self.fineAbsenceAmount = fineAbsenceAmount
		self.isRemindActive = notificationIsRemindActive
		self.notificationRemindOption = notificationRemindOption
		self.startDate = startDate
		self.endDate = endDate
	}
}
