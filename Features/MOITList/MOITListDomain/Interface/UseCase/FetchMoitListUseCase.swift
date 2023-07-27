//
//  FetchMoitListUseCase.swift
//  MOITListDomain
//
//  Created by kimchansoo on 2023/07/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

public protocol FetchMoitListUseCase {
    func execute() -> Single<[MOIT]>
}
