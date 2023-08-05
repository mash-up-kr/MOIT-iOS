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
    public let repeatCycle: RepeatCycle
    public let dayOfWeeks: [DayOfWeek]
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
        self.repeatCycle = RepeatCycle(rawValue: repeatCycle)
        self.dayOfWeeks = dayOfWeeks.map { DayOfWeek(rawValue: $0)}
        self.startTime = startTime
        self.endTime = endTime
        self.dday = dday
    }
}

public enum RepeatCycle: String {
    
    case none = "None"
    case oneWeek = "ONE_WEEK"
    case twoWeek = "TWO_WEEK"
    case threeWeek = "THREE_WEEK"
    case fourWeek = "FOUR_WEEK"
    
    public init(rawValue: String) {
        switch rawValue {
        case "ONE_WEEK":
            self = .oneWeek
        case "TWO_WEEK":
            self = .twoWeek
        case "THREE_WEEK":
            self = .threeWeek
        case "FOUR_WEEK":
            self = .fourWeek
        default:
            self = .none
        }
    }
}

public enum DayOfWeek: String {
    case monday = "MONDAY"
    case tuesday = "TUESDAY"
    case wednesday = "WEDNESDAY"
    case thursday = "THURSDAY"
    case friday = "FRIDAY"
    case saturday = "SATURDAY"
    case sunday = "SUNDAY"
    
    public init(rawValue: String) {
        switch rawValue {
        case "MONDAY":
            self = .monday
        case "TUESDAY":
            self = .tuesday
        case "WEDNESDAY":
            self = .wednesday
        case "THURSDAY":
            self = .thursday
        case "FRIDAY":
            self = .friday
        case "SATURDAY":
            self = .saturday
        case "SUNDAY":
            self = .sunday
        default:
            self = .monday
        }
    }
}
