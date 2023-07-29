//
//  MOITUserUsecase.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RxSwift

public protocol MOITUserUsecase {
    func fetchMOITUsers(moitID: String) -> Single<[MOITUserEntity]>
}
