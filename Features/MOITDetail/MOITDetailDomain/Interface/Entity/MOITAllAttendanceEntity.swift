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
        public let studyName: String
        
        public init(
            studyID: String,
            studyName: String,
            studyDate: String,
            attendances: [Attendance]
        ) {
            self.studyName = studyName
            self.studyID = studyID
            self.attendances = attendances
            self.studyDate = studyDate
        }
    }
}

public typealias AttendanceEntity = MOITAllAttendanceEntity.Study.Attendance
extension MOITAllAttendanceEntity.Study {
    public struct Attendance {
        public let userID: String
        public let nickname: String
        public let profileImage: Int
        public let status: AttendanceStatus
        public let attendanceAt: String
        
        public init(
            userID: String,
            nickname: String,
            profileImage: Int,
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
	
	public init(fromRawValue rawValue: String) {
		self = AttendanceStatus(rawValue: rawValue) ?? .UNDECIDED
	}
}
