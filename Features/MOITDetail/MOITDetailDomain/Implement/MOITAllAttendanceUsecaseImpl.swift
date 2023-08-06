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
    private let disposeBag = DisposeBag()
    public init(repository: MOITDetailRepository) {
        self.repository = repository
    }

    public func fetchAllAttendance(moitID: String, myID: String) -> Single<(studies: MOITAllAttendanceEntity, rate: MOITAllAttendanceRateEntity, myAttendance: [AttendanceEntity])> {
        self.repository.fetchAttendance(moitID: moitID)
            .map { response -> (studies: MOITAllAttendanceEntity, rate: MOITAllAttendanceRateEntity, myAttendance: [AttendanceEntity]) in
                let studies = self.convertToStudyEntity(stuides: response.studies)
                let rate = self.getRate(studies: response.studies)
                let myAttendance = response.studies.compactMap { $0.attendances.filter { "\($0.userID)" == myID }.first }
                let myAttendanceEntity = self.convertAttendanceEntities(myAttendance)
                return (studies: MOITAllAttendanceEntity(studies: studies), rate: rate, myAttendance: myAttendanceEntity)
            }
    }
    
    private func convertToStudyEntity(stuides: [MOITAllAttendanceModel.Study]) -> [MOITAllAttendanceEntity.Study] {
        stuides.enumerated().map { index, study in
            MOITAllAttendanceEntity.Study(
                studyID: "\(study.studyID)",
                studyName: self.createStudyName(order: index),
                studyDate: study.date.dateString,
                attendances: self.convertAttendanceEntities(study.attendances)
            )
        }
    }
    private func getRate(studies: [MOITAllAttendanceModel.Study]) -> MOITAllAttendanceRateEntity {
        var attendancePeople = 0
        var latePeople = 0
        var absencePeople = 0
        studies.forEach { study in
            attendancePeople += study.attendances.compactMap { AttendanceStatus(rawValue: $0.status) ?? .UNDECIDED }.filter { $0 == .ATTENDANCE }.count
            latePeople += study.attendances.compactMap { AttendanceStatus(rawValue: $0.status) ?? .UNDECIDED }.filter { $0 == .LATE }.count
            absencePeople += study.attendances.compactMap { AttendanceStatus(rawValue: $0.status) ?? .UNDECIDED }.filter { $0 == .ABSENCE }.count
        }
        let totalPeople = attendancePeople + latePeople + absencePeople
        if totalPeople == .zero {
            return MOITAllAttendanceRateEntity(attendanceRate: .zero, lateRate: .zero, absentRate: .zero)
        } 
        return MOITAllAttendanceRateEntity(
            attendanceRate: Double(attendancePeople / totalPeople),
            lateRate: Double(latePeople / totalPeople),
            absentRate: Double(absencePeople / totalPeople)
        )
    }
    
    public func getMyAttendance(studyID: String, myID: String) -> Single<[AttendanceEntity]> {
        self.repository.fetchAttendance(moitID: studyID)
            .map { $0.studies.compactMap { $0.attendances.filter { "\($0.userID)" == myID }.first } }
            .map { attendances -> [AttendanceEntity] in
                attendances.map { attendance in
                    AttendanceEntity(
                        userID: "\(attendance.userID)",
                        nickname: attendance.nickname,
                        profileImage: attendance.profileImage,
                        status: AttendanceStatus(rawValue: attendance.status) ?? .UNDECIDED,
                        attendanceAt: attendance.attendanceAt?.dateString ?? ""
                    )
                }
            }
    }
    
    private func convertAttendanceEntities(_ attendances: [MOITAllAttendanceModel.Study.Attendance]) -> [AttendanceEntity] {
        attendances.map { attendance in
            AttendanceEntity(
                userID: "\(attendance.userID)",
                nickname: attendance.nickname,
                profileImage: attendance.profileImage,
                status: AttendanceStatus(rawValue: attendance.status) ?? .UNDECIDED,
                attendanceAt: attendance.attendanceAt?.dateString ?? ""
            )
        }
    }
    
    private func createStudyName(order: Int) -> String {
        "\(order + 1)차 스터디"
    }
}
