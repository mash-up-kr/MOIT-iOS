//
//  FetchPenaltyToBePaidUseCase.swift
//  MOITListDomainImpl
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

/// 벌금리스트에서 아직 안 낸 벌금들 받아와서 합해서 보여주는 usecase
public protocol FetchPenaltyToBePaidUseCase {
    
    func execute() -> Single<Int>
}
