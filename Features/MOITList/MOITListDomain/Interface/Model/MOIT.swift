//
//  MOIT.swift
//  MOITListDomain
//
//  Created by kimchansoo on 2023/07/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOIT {
    public let id: Int
    public let name: String
    public let profileUrl: String?
    public let isEnd: Bool
    public let repeatCycle: String
    public let dayOfWeeks: [String]
    public let startTime: String
    public let endTime: String
    public let dday: Int
    
    public init(
        id: Int,
        name: String,
        profileUrl: String?,
        isEnd: Bool,
        repeatCycle: String,
        dayOfWeeks: [String],
        startTime: String,
        endTime: String,
        dday: Int
    ) {
        self.id = id
        self.name = name
        self.profileUrl = profileUrl
        self.isEnd = isEnd
        self.repeatCycle = repeatCycle
        self.dayOfWeeks = dayOfWeeks
        self.startTime = startTime
        self.endTime = endTime
        self.dday = dday
    }
}
