//
//  MOITDetailRepositoryImpl.swift
//  MOITDetailDataImpl
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITDetailData
import RxSwift

public final class MOITDetailRepositoryImpl: MOITDetailRepository {
    
    public init() {
        
    }
    public func fetchDetail(moitID: String) -> Single<MOITDetailModel> {
        return Observable.create { observer in
           let mockData = MOITDetailModel(
            moitID: "",
            name: "전자군단 스터디🤖ee",
            masterID: "ㅇ",
            description: "전자군단인데엽",
            imageURL: "image",
            scheduleDayOfWeek: ["MONDAY", "TUESDAY"],
            scheduleRepeatCycle: "ONE_WEEK",
            scheduleStartTime: "17:00",
            scheduleEndTime: "20:00",
            fineLateTime: 15,
            fineLateAmount: 2000,
            fineAbsenceTime: 30,
            fineAbsenceAmount: 5000,
            startDate: "2023-06-18",
            endDate: "2023-10-23"
           )
            observer.onNext(mockData)
            observer.onCompleted()
            return Disposables.create()
        }.asSingle()
    }
}
