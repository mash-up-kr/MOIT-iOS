//
//  MOITMyAttendanceUsecase.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/07/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RxSwift

public protocol MOITMyAttendanceUsecase {
    func getMyAttendance(studyID: String, myID: String) -> Single<[AttendanceEntity]>
}
