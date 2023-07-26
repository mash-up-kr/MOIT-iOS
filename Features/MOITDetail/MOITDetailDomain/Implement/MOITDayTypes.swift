//
//  MOITDayTypes.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

enum DayOfWeeks: String {
    case MONDAY
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRIDAY
    case SATURDAY
    case SUNDAY
    
    var toKor: String {
        switch self {
        case .MONDAY: return "월요일"
        case .TUESDAY: return "화요일"
        case .WEDNESDAY: return "수요일"
        case .THURSDAY: return "목요일"
        case .FRIDAY: return "금요일"
        case .SATURDAY: return "토요일"
        case .SUNDAY: return "일요일"
        }
    }
}

enum RepeatCycle: String {
    case 없음 = "NONE"
    case 매주 = "ONE_WEEK"
    case 격주 = "TWO_WEEK"
    case 매달 = "FOUR_WEEK"
}
