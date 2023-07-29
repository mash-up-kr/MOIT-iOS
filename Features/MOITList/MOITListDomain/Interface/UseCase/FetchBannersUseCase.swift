//
//  FetchPenaltyToBePaidUseCase.swift
//  MOITListDomainImpl
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

/// 배너 모델 받아오는 UseCase
public protocol FetchBannersUseCase {
    
    func execute() -> Single<[Banner]>
}
