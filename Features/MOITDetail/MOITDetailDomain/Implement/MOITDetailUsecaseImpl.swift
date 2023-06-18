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
                let scheduleDescription = self.moitScheduleDescription(
                    scheduleDayOfWeek: response.scheduleDayOfWeek,
                    scheduleRepeatCycle: response.scheduleRepeatCycle,
                    scheduleStartTime: response.scheduleStartTime,
                    scheduleEndTime: response.scheduleEndTime
                )
                let ruleShortDescription = self.ruleShortDescription(
                    fineLateTime: response.fineLateTime,
                    fineAbsenceTime: response.fineAbsenceTime
                )
                let ruleLongDescription = self.ruleLongDescription(
                    fineLateTime: response.fineLateTime,
                    fineLateAmount: response.fineLateAmount,
                    fineAbsenceTime: response.fineAbsenceTime,
                    fineAbsenceAmount: response.fineAbsenceAmount
                )
                let periodDescription = self.periodDescription(
                    startDate: response.startDate,
                    endDate: response.endDate
                )
                return MOITDetailEntity(
                    moitID: response.moitID,
                    moitName: response.name,
                    masterID: response.masterID,
                    description: self.moitDescription(response.description),
                    imageURL: response.imageURL,
                    scheduleDescription: scheduleDescription,
                    ruleShortDescription: ruleShortDescription,
                    ruleLoneDescription: ruleLongDescription,
                    periodDescription: periodDescription
                )
            }.asObservable()
            .asSingle()
    }
    
    private func moitDescription(_ description: String) -> String? {
        description.isEmpty ? nil : description
    }
    
    private func moitScheduleDescription(
        scheduleDayOfWeek: [String],
        scheduleRepeatCycle: String,
        scheduleStartTime: String,
        scheduleEndTime: String
    ) -> String {
        var days = ""
        
        scheduleDayOfWeek.forEach { dayOfWeek in
            if !days.isEmpty { days += ", " }
            guard let day = DayOfWeeks(rawValue: dayOfWeek)
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
    
    private func ruleLongDescription(
        fineLateTime: Int,
        fineLateAmount: Int,
        fineAbsenceTime: Int,
        fineAbsenceAmount: Int
    ) -> String {
        return """
        지각 \(fineLateTime)분 부터 \(fineAbsenceAmount.toDecimalString)원
        결석 \(fineAbsenceTime)분 부터 \(fineAbsenceAmount.toDecimalString)원
        """
    }
    
    private func periodDescription(
        startDate: String,
        endDate: String
    ) -> String {
        return "테스트기간"
    }
}
