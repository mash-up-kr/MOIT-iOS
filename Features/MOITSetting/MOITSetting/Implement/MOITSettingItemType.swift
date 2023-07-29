//
//  MOITSettingItemType.swift
//  MOITSettingImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit

protocol MOITSettingItemType {
    var height: CGFloat { get }
}

enum MOITSettingTitleItemType: CaseIterable,
                               MOITSettingItemType {

    case 프로필수정
    case 개인정보처리방침
    case 서비스이용약관
    case 피드백
    case 계정삭제
    case 로그아웃
    
    var title: String {
        switch self {
        case .개인정보처리방침: return "개인 정보 처리방침"
        case .계정삭제: return "계정 삭제"
        case .로그아웃: return "로그아웃"
        case .피드백: return "피드백"
        case .서비스이용약관: return "서비스 이용 약관"
        case .프로필수정: return "프로필 수정"
        }
    }
    
    var height: CGFloat { 63 }
}

enum MOITSettingToggleItemType: CaseIterable,
                                MOITSettingItemType {
    typealias CellType = MOITSettingToggleCollectionViewCell.Type
    
    case 앱푸시알림설정
    
    var title: String {
        switch self {
        case .앱푸시알림설정: return "앱 푸시 알림 설정"
        }
    }
    
    var description: String {
        switch self {
        case .앱푸시알림설정: return "알람이 오지 않는 경우 기기의 알림 설정을 변경해주세요."
        }
    }
    
    var height: CGFloat { 71 }
}

enum MOITSettingDividerItemType: MOITSettingItemType {
    typealias CellType = MOITSettingDividerCollectionViewCell.Type
    case divider
    
    var height: CGFloat { 1 }
}
