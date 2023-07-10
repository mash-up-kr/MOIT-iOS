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

public struct MOITAllAttendanceUsecaseImpl: MOITAllAttendanceUsecase {
    
    private let repository: MOITDetailRepository
    
    public init(repository: MOITDetailRepository) {
        self.repository = repository
    }
    
    public func fetchAllAttendance(moitID: String) -> Single<MOITAllAttendanceEntity> {
        return repository.fetchAttendance(moitID: moitID)
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
