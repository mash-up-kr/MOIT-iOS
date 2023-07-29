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

enum NotificationRemindOption: String {
	case studyDay10am = "STUDY_DAY_10_AM"
	case before1Hour = "BEFORE_1_HOUR"
	case before30Minute = "BEFORE_30_MINUTE"
	case before10Minute = "BEFORE_10_MINUTE"
	
	var toKor: String {
		switch self {
		case .studyDay10am: return "당일 오전 10시"
		case .before1Hour: return "1시간 전"
		case .before30Minute: return "30분 전"
		case .before10Minute: return "10분 전"
		}
	}
	
	init(fromRawValue rawValue: String) {
		self = NotificationRemindOption(rawValue: rawValue) ?? .studyDay10am
	}
}
