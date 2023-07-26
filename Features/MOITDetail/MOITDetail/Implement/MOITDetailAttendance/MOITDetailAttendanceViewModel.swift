//
//  MOITDetailAttendanceViewModel.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/07/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RxSwift
import DesignSystem
import Collections

struct MOITDetailAttendanceViewModel {
    struct AttendanceViewModel {
        enum Attendance {
            case attend
            case late
            case absent
            
            var toChipeType: MOITChipType {
                switch self {
                case .absent: return .absent
                case .late: return .late
                case .attend: return .attend
                }
            }
        }
        let profileImageURL: Int
        let tilte: String
        let detail: String
        let attendance: Attendance
    }
    var studies: OrderedDictionary<String, MOITAttendanceStudyViewModel>
    let attendances: OrderedDictionary<String, [AttendanceViewModel]>
    let myAttendances: [AttendanceViewModel]
    let attendanceRate: Double
    let lateRate: Double
    let absenceRate: Double
}
