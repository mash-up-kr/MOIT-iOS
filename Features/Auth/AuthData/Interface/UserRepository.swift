//
//  UserRepository.swift
//  AuthData
//
//  Created by 최혜린 on 2023/07/28.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

public protocol UserRepository {
	func fetchUserInfo() -> Single<UserInfoDTO>
    func withdraw() -> Single<Void>
}
