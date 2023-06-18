//
//  StudyPreviewModel.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/08.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct StudyPreviewModel {
    let remainingDate: String
    let profileURL: URL
    let studyName: String
    let studyProgressDescription: String
    
    public init(remainingDate: String, profileURL: URL, studyName: String, studyProgressDescription: String) {
        self.remainingDate = remainingDate
        self.profileURL = profileURL
        self.studyName = studyName
        self.studyProgressDescription = studyProgressDescription
    }
}

extension StudyPreviewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(studyName)
        hasher.combine(remainingDate)
        hasher.combine(profileURL)
        hasher.combine(studyProgressDescription)
    }
    
    public static func == (lhs: StudyPreviewModel, rhs: StudyPreviewModel) -> Bool {
        return lhs.studyName == rhs.studyName &&
            lhs.remainingDate == rhs.remainingDate &&
            lhs.profileURL == rhs.profileURL &&
            lhs.studyProgressDescription == rhs.studyProgressDescription
    }
}

