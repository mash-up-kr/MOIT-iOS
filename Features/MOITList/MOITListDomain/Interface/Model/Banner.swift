//
//  Banner.swift
//  MOITListDomain
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public enum Banner {
    
    case attendence(AttendenceBanner)
    case fine(FineBanner)
    case empty
}

public struct AttendenceBanner {
    
    public let userId: Int
    public let moitId: Int
    public let moitName: String
    public let studyId: Int
    public let studyStartAt: Date
    public let studyLateAt: Date
    public let studyAbsenceAt: Date
    
    public init(
        userId: Int,
        moitId: Int,
        moitName: String,
        studyId: Int,
        studyStartAt: String,
        studyLateAt: String,
        studyAbsenceAt: String
    ) {
        self.userId = userId
        self.moitId = moitId
        self.moitName = moitName
        self.studyId = studyId
        self.studyStartAt = studyStartAt.toDate()
        self.studyLateAt = studyLateAt.toDate()
        self.studyAbsenceAt = studyAbsenceAt.toDate()
    }
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:s"
        return dateFormatter.date(from: self) ?? Date()
    }
}

public struct FineBanner {
    
    public let userId: Int
    public let moitId: Int
    public let moitName: String
    public let fineAmount: Int
    
    public init(
        userId: Int,
        moitId: Int,
        moitName: String,
        fineAmount: Int
    ) {
        self.userId = userId
        self.moitId = moitId
        self.moitName = moitName
        self.fineAmount = fineAmount
    }
}
