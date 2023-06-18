//
//  MOITDayTypes.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

enum DayOfWeeks: String {
    case 월요일 = "MONDAY"
    case 화요일 = "TUESDAY"
    case 수요일 = "WEDNESDAY"
    case 목요일 = "THURSDAY"
    case 금요일 = "FRIDAY"
    case 토요일 = "SATURDAY"
    case 일요일 = "SUNDAY"
}

enum RepeatCycle: String {
    case 없음 = "NONE"
    case 매주 = "ONE_WEEK"
    case 격주 = "TWO_WEEK"
    case 매달 = "FOUR_WEEK"
}
