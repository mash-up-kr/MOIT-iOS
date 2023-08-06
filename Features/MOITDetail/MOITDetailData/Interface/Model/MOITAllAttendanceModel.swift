//
//  MOITAllAttendanceModel.swift
//  MOITDetailData
//
//  Created by 송서영 on 2023/07/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOITAllAttendanceModel: Decodable {
    public let studies: [Study]
    
    enum CodingKeys: String, CodingKey {
        case studies
    }
    
    public struct Study: Decodable {
        public let studyID: Int
        public let date: String
        public let order: Int
        public let attendances: [Attendance]
        
        enum CodingKeys: String, CodingKey {
            case studyID = "studyId"
            case attendances, date, order
        }
        
        public struct Attendance: Decodable {
            public let userID: Int
            public let nickname: String
            public let profileImage: Int
            public let status: String
            public let attendanceAt: String?
            
            enum CodingKeys: String, CodingKey {
                case userID = "userId"
                case nickname, profileImage, status, attendanceAt
            }
        }
    }
}
