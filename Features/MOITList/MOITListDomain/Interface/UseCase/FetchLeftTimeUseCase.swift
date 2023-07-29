//
//  FetchLeftTimeUseCase.swift
//  MOITListDomain
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

/// 오늘 진행하는 스터디 중에 가장 빨리 시작하는 moit의 이름과 남은 시간 가져온다.
public protocol FetchLeftTimeUseCase {
    /// 출석 10분 전부터
    /// 이후면 지각까지 얼마나 남았는지
    /// 지각 이후면 결석까지 얼마나 남았는지
    func execute(moitList: [MOIT]) -> (moitName: String, time: Date)
}
