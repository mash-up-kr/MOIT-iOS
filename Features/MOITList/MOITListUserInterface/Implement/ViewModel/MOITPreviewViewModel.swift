//
//  MOITPreviewViewModel.swift
//  MOITListUserInterface
//
//  Created by kimchansoo on 2023/07/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOITPreviewViewModel {
    let remainingDate: Int
    let profileUrlString: String?
    let studyName: String
    let studyProgressDescription: String?
    
    public init(
        remainingDate: Int,
        profileUrlString: String?,
        studyName: String,
        studyProgressDescription: String?
    ) {
        self.remainingDate = remainingDate
        self.profileUrlString = profileUrlString
        self.studyName = studyName
        self.studyProgressDescription = studyProgressDescription
    }
}
