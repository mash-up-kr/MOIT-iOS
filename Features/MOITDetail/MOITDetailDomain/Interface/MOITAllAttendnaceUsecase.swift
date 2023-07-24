//
//  MOITAllAttendnaceUsecase.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/07/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RxSwift

public protocol MOITAllAttendanceUsecase {
    func fetchAllAttendance(moitID: String, myID: String) -> Single<(studies: MOITAllAttendanceEntity, rate: MOITAllAttendanceRateEntity, myAttendance: [AttendanceEntity])>
}
