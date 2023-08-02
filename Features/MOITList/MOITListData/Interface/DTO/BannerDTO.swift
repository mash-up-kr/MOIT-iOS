//
//  BannerDTO.swift
//  AuthDataImpl
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListDomain

public struct BannerDTO: Codable {
    public let attendanceBanners: [AttendanceBannerDTO]
    public let fineBanners: [FineBannerDTO]
    public let defaultBanners: [DefaultBannerDTO]
}

public struct AttendanceBannerDTO: Codable {
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

public struct FineBannerDTO: Codable {
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

public struct DefaultBannerDTO: Codable {
    let userId: Int
    
    public func toBanner() -> Banner {
        Banner.empty
    }
}
