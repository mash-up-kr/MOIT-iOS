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
    case penalty(amount: String) // TODO: 서버에서 어떻게 내려줄지 합의봐야됨 (int로 내려주는지 string으로 내려주는지?)
    case attendanceRating

    func alarmTitle(with studyName: String) -> String {
        switch self {
        case .attendanceCheck: return "\(studyName) 스터디\n출석체크를 시작해보세요!"
        case .penalty: return "\(studyName) 스터디\n벌금을 납부하고 인증하세요!"
        case .attendanceRating: return "더 열심히 스터디 참여하기\n오늘도 화이팅!"
        }
    }
    
    var descriptionTitle: String {
        switch self {
        case .attendanceCheck: return "남은 시간"
        case .penalty: return "쌓인 벌금"
        case .attendanceRating: return ""
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .attendanceCheck: return "출석체크하기"
        case .penalty: return "벌금 납부하기"
        case .attendanceRating: return "내 출결 확인하기"
        }
    }
}

extension MOITAlarmType: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .attendanceCheck(let remainSeconds):
            hasher.combine(remainSeconds)
        case .penalty(let amount):
            hasher.combine(amount)
        case .attendanceRating:
            hasher.combine(0)
        }
    }
}
