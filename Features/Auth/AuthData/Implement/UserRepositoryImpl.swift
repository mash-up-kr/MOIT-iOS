//
//  UserRepositoryImpl.swift
//  AuthData
//
//  Created by 최혜린 on 2023/07/28.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthData
import MOITNetwork
import TokenManager

import RxSwift

public final class UserRepositoryImpl: UserRepository {
	
	private let network: Network
	private let tokenManger: TokenManager
	
	public init(
		network: Network,
		tokenManager: TokenManager
	) {
		self.network = network
		self.tokenManger = tokenManager
	}
	
	public func fetchUserInfo() -> Single<UserInfoDTO> {
		let endpoint = UserEndpoint.fetchUserInfo()
		return network.request(with: endpoint)
	}
}
