//
//  MOITDetailUsecaseImpl.swift
//  MOITDetailDomainImpl
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITDetailDomain
import MOITDetailData
import RxSwift
import MOITFoundation

public final class MOITDetailUsecaseImpl: MOITDetailUsecase {
	private let repository: MOITDetailRepository
	
	public init(repository: MOITDetailRepository) {
		self.repository = repository
	}
	
	public func moitDetail(with ID: String) -> Single<MOITDetailEntity> {
		return self.repository.fetchDetail(moitID: ID)
			.compactMap { [weak self] response -> MOITDetailEntity? in
				guard let self = self else { return nil }
				return self.convertToMOITDetailEntity(from: response)
			}.asObservable()
			.asSingle()
	}
	
	private func convertToMOITDetailEntity(
		from moitDetailModel: MOITDetailModel
	) -> MOITDetailEntity {
		let scheduleDescription = self.moitScheduleDescription(
			scheduleDayOfWeeks: moitDetailModel.scheduleDayOfWeeks,
			scheduleRepeatCycle: moitDetailModel.scheduleRepeatCycle,
			scheduleStartTime: moitDetailModel.scheduleStartTime,
			scheduleEndTime: moitDetailModel.scheduleEndTime
		)
		let ruleShortDescription = self.ruleShortDescription(
			fineLateTime: moitDetailModel.fineLateTime,
			fineAbsenceTime: moitDetailModel.fineAbsenceTime
		)
		let ruleLongDescription = self.ruleLongDescription(
			fineLateTime: moitDetailModel.fineLateTime,
			fineLateAmount: moitDetailModel.fineLateAmount,
			fineAbsenceTime: moitDetailModel.fineAbsenceTime,
			fineAbsenceAmount: moitDetailModel.fineAbsenceAmount
		)
		let notificationDescription = self.notificationDescription(
			remindOption: moitDetailModel.notificationRemindOption ?? ""
		)
		let periodDescription = self.periodDescription(
			startDate: moitDetailModel.startDate,
			endDate: moitDetailModel.endDate
		)
		return MOITDetailEntity(
			moitID: "\(moitDetailModel.moitID)",
			moitName: moitDetailModel.name,
			masterID: "\(moitDetailModel.masterID)",
			description: self.moitDescription(moitDetailModel.description ?? "전ㅈr군단"),
			imageURL: moitDetailModel.imageURL,
			scheduleDescription: scheduleDescription,
			ruleShortDescription: ruleShortDescription,
			ruleLoneDescription: ruleLongDescription,
            periodDescription: periodDescription,
            invitationCode: moitDetailModel.invitationCode,
            isNotificationActive: moitDetailModel.notificationIsRemindActive,
			notificationDescription: notificationDescription
		)
	}
    
	public func moitDescription(_ description: String) -> String? {
        description.isEmpty ? nil : description
    }
    
	public func moitScheduleDescription(
        scheduleDayOfWeeks: [String],
        scheduleRepeatCycle: String,
        scheduleStartTime: String,
        scheduleEndTime: String
    ) -> String {
        var days = ""
        
        scheduleDayOfWeeks.forEach { dayOfWeek in
            if !days.isEmpty { days += ", " }
            guard let day = DayOfWeeks(rawValue: dayOfWeek)?.toKor
            else { return }
            days += "\(day)"
        }
        guard let repeatCycle = RepeatCycle(rawValue: scheduleRepeatCycle)
        else { return "" }
        return "\(repeatCycle) \(days) \(scheduleStartTime) - \(scheduleEndTime)"
    }
    
	private func ruleShortDescription(
        fineLateTime: Int,
        fineAbsenceTime: Int
    ) -> String {
        return "지각 \(fineLateTime)분 부터, 결석 \(fineAbsenceTime)분 부터"
    }
    
    public func ruleLongDescription(
        fineLateTime: Int,
        fineLateAmount: Int,
        fineAbsenceTime: Int,
        fineAbsenceAmount: Int
    ) -> String {
        return """
        지각 \(fineLateTime)분 부터 \(fineLateAmount.toDecimalString)원
        결석 \(fineAbsenceTime)분 부터 \(fineAbsenceAmount.toDecimalString)원
        """
    }
    
    public func periodDescription(
        startDate: String,
        endDate: String
    ) -> String {
        return "\(startDate.dateKORString) - \(endDate.dateKORString)"
    }

    public func notificationDescription(
		remindOption: String
	) -> String {
        return NotificationRemindOption(fromRawValue: remindOption).toKor
	}
}
