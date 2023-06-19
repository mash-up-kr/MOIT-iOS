//
//  PostJoinInfoUseCase.swift
//  SignUpDomain
//
//  Created by 김찬수 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

public protocol PostJoinInfoUseCase {
    func execute(name: String, inviteCode: String?) -> Single<Int>
}
