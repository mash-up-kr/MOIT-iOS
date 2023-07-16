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
                let studies = response.studies.map { study in
                    MOITAllAttendanceEntity.Study(
                        studyID: "\(study.studyID)",
                        studyName: self.createStudyName(order: study.order),
                        studyDate: study.date.dateString,
                        attendances: self.convertAttendanceEntities(study.attendances)
                    )
                }
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
