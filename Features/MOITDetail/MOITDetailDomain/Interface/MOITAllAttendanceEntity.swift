//
//  MOITAllAttendanceEntity.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/07/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOITAllAttendanceEntity {
    public let studies: [Study]
    
    public init(studies: [Study]) {
        self.studies = studies
    }
}

extension MOITAllAttendanceEntity {
    public struct Study {
        public let studyID: String
        public let attendances: [Attendance]
        public let studyDate: String
        
        public init(
            studyID: String,
            attendances: [Attendance],
            studyDate: String
        ) {
            self.studyID = studyID
            self.attendances = attendances
            self.studyDate = studyDate
        }
    }
}

extension MOITAllAttendanceEntity.Study {
    public struct Attendance {
        public let userID: String
        public let nickname: String
        public let profileImage: String
        public let status: AttendanceStatus
        public let attendanceAt: String
        
        public init(
            userID: String,
            nickname: String,
            profileImage: String,
            status: AttendanceStatus,
            attendanceAt: String
        ) {
            self.userID = userID
            self.nickname = nickname
            self.profileImage = profileImage
            self.status = status
            self.attendanceAt = attendanceAt
        }
    }
}

public enum AttendanceStatus: String {
    case UNDECIDED
    case ATTENDANCE
    case LATE
    case ABSENCE
}
