//
//  FetchUserInfoUseCase.swift
//  AuthDomain
//
//  Created by 최혜린 on 2023/07/28.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthData
import AuthDomain

import RxSwift

public class FetchUserInfoUseCaseImpl: FetchUserInfoUseCase {
	
	private let repository: UserRepository
	
	public init(
		repository: UserRepository
	) {
		self.repository = repository
	}
	
	public func execute() -> Single<UserInfoEntity> {
		return repository.fetchUserInfo()
			.compactMap { userInfoDTO -> UserInfoEntity? in
				return UserInfoEntity(
					userID: userInfoDTO.id,
					nickname: userInfoDTO.nickname,
					email: userInfoDTO.email
				)
			}
			.asObservable().asSingle()
	}
}
