//
//  StubMOITAllAttendanceUsecase.swift
//  MOITDetailDemoApp
//
//  Created by 송서영 on 2023/07/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITDetailDomain
import RxSwift

final class StubMOITAllAttendanceUsecase: MOITAllAttendanceUsecase {
    func fetchAllAttendance(moitID: String, myID: String) -> Single<(studies: MOITAllAttendanceEntity, rate: MOITAllAttendanceRateEntity, myAttendance: [AttendanceEntity])> {
        
        .just((studies: MOITAllAttendanceEntity(studies: [
            MOITAllAttendanceEntity.Study(
                studyID: "1",
                studyName: "1차 스터디",
                studyDate: "2023.04.21",
                attendances: [
                    AttendanceEntity(userID: "1", nickname: "김매숑", profileImage: 0, status: .ATTENDANCE, attendanceAt: "17:02"),
                    AttendanceEntity(userID: "2", nickname: "박매숑", profileImage: 1, status: .LATE, attendanceAt: "17:03"),
                    AttendanceEntity(userID: "3", nickname: "이매숑", profileImage: 2, status: .ABSENCE, attendanceAt: "17:00")
                ]
            ),
            MOITAllAttendanceEntity.Study(
                studyID: "2",
                studyName: "2차 스터디",
                studyDate: "2023.04.22",
                attendances: [
                    AttendanceEntity(userID: "1", nickname: "김매숑", profileImage: 3, status: .ATTENDANCE, attendanceAt: "17:02"),
                    AttendanceEntity(userID: "2", nickname: "박매숑", profileImage: 4, status: .LATE, attendanceAt: "17:03"),
                    AttendanceEntity(userID: "3", nickname: "이매숑", profileImage: 5, status: .ABSENCE, attendanceAt: "17:00")
                ]
            ),
            MOITAllAttendanceEntity.Study(
                studyID: "3",
                studyName: "3차 스터디",
                studyDate: "2023.04.23",
                attendances: [
                ]
            )
        ]), rate: MOITAllAttendanceRateEntity(attendanceRate: 0.2, lateRate: 0.7, absentRate: 0.1), myAttendance: [AttendanceEntity(userID: myID, nickname: "김매숑", profileImage: 6, status: .ABSENCE, attendanceAt: "17:02"),AttendanceEntity(userID: myID, nickname: "김매숑", profileImage: 7, status: .ATTENDANCE, attendanceAt: "17:03"),AttendanceEntity(userID: myID, nickname: "김매숑", profileImage: 8, status: .LATE, attendanceAt: "17:06")]))
    }
}
