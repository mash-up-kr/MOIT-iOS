//
//  MOITAlarmType.swift
//  DesignSystem
//
//  Created by 송서영 on 2023/06/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public enum MOITAlarmType: Equatable {
    
    case attendanceCheck(remainSeconds: Int)
    case fine(amount: String) // TODO: 서버에서 어떻게 내려줄지 합의봐야됨 (int로 내려주는지 string으로 내려주는지?)
    case attendanceRate(percent: String)

    func alarmTitle(with studyName: String) -> String {
        switch self {
        case .attendanceCheck: return "\(studyName) 스터디\nattendanceCheck를 시작해보세요!"
        case .fine: return "\(studyName) 스터디\nfine을 납부하고 인증하세요!"
        case .attendanceRate: return "더 열심히 \(studyName) 스터디\n참여해보세요!"
        }
    }
    
    var descriptionTitle: String {
        switch self {
        case .attendanceCheck: return "남은 시간"
        case .fine: return "쌓인 fine"
        case .attendanceRate: return "스터디 attendanceRate"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .attendanceCheck: return "attendanceCheck하기"
        case .fine: return "fine 납부하기"
        case .attendanceRate: return "내 출결 확인하기"
        }
    }
}
