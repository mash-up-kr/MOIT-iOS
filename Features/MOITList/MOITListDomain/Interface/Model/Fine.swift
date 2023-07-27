//
//  Fine.swift
//  MOITListDomain
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct Fine {
    let id: Int
    let fineAmount: Int
    let userId: Int
    let userNickname: String
    let attendanceStatus: AttendanceStatus
    let studyOrder: Int
    let isApproved: Bool
    let approveAt: Date
    
    public init(
        id: Int,
        fineAmount: Int,
        userId: Int,
        userNickname: String,
        attendanceStatus: AttendanceStatus,
        studyOrder: Int,
        isApproved: Bool,
        approveAt: Date
    ) {
        self.id = id
        self.fineAmount = fineAmount
        self.userId = userId
        self.userNickname = userNickname
        self.attendanceStatus = attendanceStatus
        self.studyOrder = studyOrder
        self.isApproved = isApproved
        self.approveAt = approveAt
    }
}

public enum AttendanceStatus: Codable {
    case late, absence
}
