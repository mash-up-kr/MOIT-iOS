//
//  MOITDetailUsecase.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITDetailData

import RxSwift

public protocol MOITDetailUsecase {
    func moitDetail(with ID: String) -> Single<MOITDetailEntity>
	func moitDescription(_ description: String) -> String?
	func moitScheduleDescription(
		scheduleDayOfWeeks: [String],
		scheduleRepeatCycle: String,
		scheduleStartTime: String,
		scheduleEndTime: String
	) -> String
	func ruleLongDescription(
		fineLateTime: Int,
		fineLateAmount: Int,
		fineAbsenceTime: Int,
		fineAbsenceAmount: Int
	) -> String
	func periodDescription(
		startDate: String,
		endDate: String
	) -> String
	func notificationDescription(
		remindOption: String
	) -> String
}
