//
//  UserUseCase.swift
//  AuthDomainImpl
//
//  Created by 송서영 on 2023/08/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RxSwift

public protocol UserUseCase {
    func logout() -> Single<Void>
    func withdraw() -> Single<Void>
}
