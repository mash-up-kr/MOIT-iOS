//
//  FineDTO.swift
//  MOITListData
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListDomain
// TODO: - fine 관련된 부분 나중에 이동

public struct FineDTO: Codable {
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
    
    public func toFine() -> Fine {
        Fine(
            id: self.id,
            fineAmount: self.fineAmount,
            userId: self.userId,
            userNickname: self.userNickname,
            attendanceStatus: self.attendanceStatus,
            studyOrder: self.studyOrder,
            isApproved: self.isApproved,
            approveAt: self.approveAt
        )
    }
}

