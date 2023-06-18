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

public final class MOITDetailUsecaseImpl: MOITDetailUsecase {
    private let repository: MOITDetailRepository
    
    public init(repository: MOITDetailRepository) {
        self.repository = repository
    }
    
    public func moitDetail(with ID: String) -> Single<MOITDetailEntity> {
        return self.repository.fetchDetail(moitID: ID)
            .compactMap { [weak self] response -> MOITDetailEntity? in
                guard let self = self else { return nil }
                return MOITDetailEntity(
                    moitID: response.moitID,
                    moitName: response.name,
                    masterID: response.masterID,
                    description: self.moitDescription(response.description),
                    imageURL: response.imageURL,
                    scheduleDescription: self.moitScheduleDescription(
                        scheduleDayOfWeek: response.scheduleDayOfWeek,
                        scheduleRepeatCycle: response.scheduleRepeatCycle,
                        scheduleStartTime: response.scheduleStartTime,
                        scheduleEndTime: response.scheduleEndTime
                    ),
                    ruleShortDescription: self.ruleShortDescription(
                        fineLateTime: response.fineLateTime,
                        fineLateAmount: response.fineLateAmount,
                        fineAbsenceTime: response.fineAbsenceTime,
                        fineAbsenceAmount: response.fineAbsenceAmount
                    ),
                    ruleLoneDescription: self.ruleLongDescription(
                        fineLateTime: response.fineLateTime,
                        fineLateAmount: response.fineLateAmount,
                        fineAbsenceTime: response.fineAbsenceTime,
                        fineAbsenceAmount: response.fineAbsenceAmount
                    ),
                    periodDescription: self.periodDescription(
                        startDate: response.startDate,
                        endDate: response.endDate
                    )
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
        return "테스트일정"
    }
    
    private func ruleShortDescription(
        fineLateTime: Int,
        fineLateAmount: Int,
        fineAbsenceTime: Int,
        fineAbsenceAmount: Int
    ) -> String {
        return "테스트짧은규칙"
    }
    
    private func ruleLongDescription(
        fineLateTime: Int,
        fineLateAmount: Int,
        fineAbsenceTime: Int,
        fineAbsenceAmount: Int
    ) -> String {
        return "테스트긴규칙"
    }
    
    private func periodDescription(
        startDate: String,
        endDate: String
    ) -> String {
        return "테스트기간"
    }
}
