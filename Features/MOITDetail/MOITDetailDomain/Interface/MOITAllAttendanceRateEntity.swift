//
//  MOITAllAttendanceRateEntity.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/07/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOITAllAttendanceRateEntity {
    public let attendanceRate: Double
    public let lateRate: Double
    public let absentRate: Double
    
    public init(
        attendanceRate: Double,
        lateRate: Double,
        absentRate: Double
    ) {
        self.attendanceRate = attendanceRate
        self.lateRate = lateRate
        self.absentRate = absentRate
    }
}
