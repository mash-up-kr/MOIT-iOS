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

import RxSwift

public final class UserRepositoryImpl: UserRepository {
	
	private let network: Network
	
	public init(
		network: Network
	) {
		self.network = network
	}
	
	public func fetchUserInfo() -> Single<UserInfoDTO> {
		let endpoint = UserEndpoint.fetchUserInfo()
		return network.request(with: endpoint)
	}
    
    public func withdraw() -> Single<Void> {
        return network.request(with: UserEndpoint.withdraw())
            .map { _ in return }
    }
}
