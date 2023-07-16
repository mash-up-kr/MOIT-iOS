//
//  MOITAllAttendanceUsecaseImpl.swift
//  MOITDetailDomainImpl
//
//  Created by 송서영 on 2023/07/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITDetailDomain
import MOITDetailData
import RxSwift
import MOITFoundation

public struct MOITAllAttendanceUsecaseImpl: MOITAllAttendanceUsecase,
                                            MOITMyAttendanceUsecase {
    
    private let repository: MOITDetailRepository
    private let attendancesModel = PublishSubject<MOITAllAttendanceModel>()
    private let disposeBag = DisposeBag()
    public init(repository: MOITDetailRepository) {
        self.repository = repository
    }

    public func fetchAllAttendance(moitID: String) -> Single<MOITAllAttendanceEntity> {
        self.repository.fetchAttendance(moitID: moitID)
            .map { response -> MOITAllAttendanceEntity in
                let studies = [
                                    MOITAllAttendanceEntity.Study(
                                        studyID: "1",
                                        studyName: "1차 스터디",
                                        studyDate: "2023.04.21",
                                        attendances: [
                                            AttendanceEntity(userID: "1", nickname: "김매숑", profileImage: "2", status: .ATTENDANCE, attendanceAt: "17:02"),
                                            AttendanceEntity(userID: "2", nickname: "박매숑", profileImage: "2", status: .LATE, attendanceAt: "17:03"),
                                            AttendanceEntity(userID: "3", nickname: "이매숑", profileImage: "2", status: .ABSENCE, attendanceAt: "17:00")
                                        ]
                                    ),
                                    MOITAllAttendanceEntity.Study(
                                        studyID: "2",
                                        studyName: "2차 스터디",
                                        studyDate: "2023.04.22",
                                        attendances: [
                                            AttendanceEntity(userID: "1", nickname: "김매숑", profileImage: "2", status: .ATTENDANCE, attendanceAt: "17:02"),
                                            AttendanceEntity(userID: "2", nickname: "박매숑", profileImage: "2", status: .LATE, attendanceAt: "17:03"),
                                            AttendanceEntity(userID: "3", nickname: "이매숑", profileImage: "2", status: .ABSENCE, attendanceAt: "17:00")
                                        ]
                                    ),
                                    MOITAllAttendanceEntity.Study(
                                        studyID: "3",
                                        studyName: "3차 스터디",
                                        studyDate: "2023.04.23",
                                        attendances: [
                                        ]
                                    )
                                ]
                return MOITAllAttendanceEntity(studies: studies)
            }
    }
    
    public func getMyAttendance(studyID: String, myID: String) -> Single<[AttendanceEntity]> {
        self.repository.fetchAttendance(moitID: studyID)
            .map { $0.studies.compactMap { $0.attendances.filter { "\($0.userID)" == myID }.first } }
            .map { attendances -> [AttendanceEntity] in
                attendances.map { attendance in
                    AttendanceEntity(
                        userID: "\(attendance.userID)",
                        nickname: attendance.nickname,
                        profileImage: "3",
                        status: AttendanceStatus(rawValue: attendance.status) ?? .UNDECIDED,
                        attendanceAt: attendance.attendanceAt.dateString
                    )
                }
              
            }
    }
    
    private func convertAttendanceEntities(_ attendances: [MOITAllAttendanceModel.Study.Attendance]) -> [MOITAllAttendanceEntity.Study.Attendance] {
        attendances.map { attendance in
            MOITAllAttendanceEntity.Study.Attendance(
                userID: "\(attendance.userID)",
                nickname: attendance.nickname,
                profileImage: "attendance.profileImage",
                status: AttendanceStatus(rawValue: attendance.status) ?? .UNDECIDED,
                attendanceAt: attendance.attendanceAt.dateString
            )
        }
    }
    
    private func createStudyName(order: Int) -> String {
        "\(order + 1)차 스터디"
    }
}
