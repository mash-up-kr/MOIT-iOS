//
//  BannerDTO.swift
//  AuthDataImpl
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListDomain

public struct BannerDTO: Decodable {
    public let attendanceBanners: [AttendanceBannerDTO]
    public let fineBanners: [FineBannerDTO]
    public let defaultBanners: [DefaultBannerDTO]
    
    enum CodingKeys: String, CodingKey {
        case attendanceBanners = "studyAttendanceStartBanners"
        case fineBanners = "moitUnapprovedFineExistBanners"
        case defaultBanners = "defaultBanners"
    }
}

public struct AttendanceBannerDTO: Decodable {
    let userId: Int
    let moitId: Int
    let moitName: String
    let studyId: Int
    let studyStartAt: Date
    let studyLateAt: Date
    let studyAbsenceAt: Date
    
    public func toBanner() -> Banner {
        Banner.attendence(
            AttendenceBanner(
                userId: self.userId,
                moitId: self.moitId,
                moitName: self.moitName,
                studyId: self.studyId,
                studyStartAt: self.studyStartAt,
                studyLateAt: self.studyLateAt,
                studyAbsenceAt: self.studyAbsenceAt
            )
        )
    }
}

public struct FineBannerDTO: Decodable {
    let userId: Int
    let moitId: Int
    let moitName: String
    let fineAmount: Int
    
    public func toBanner() -> Banner {
        Banner.fine(
            FineBanner(
                userId: self.userId,
                moitId: self.moitId,
                moitName: self.moitName,
                fineAmount: self.fineAmount
            )
        )
    }
}

public struct DefaultBannerDTO: Decodable {
    let userId: Int
    
    public func toBanner() -> Banner {
        Banner.empty
    }
}
