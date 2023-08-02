//
//  SaveUserIDUseCaseImpl.swift
//  AuthDomainImpl
//
//  Created by 최혜린 on 2023/07/28.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthDomain
import TokenManager

public final class SaveUserIDUseCaseImpl: SaveUserIDUseCase {
	
	private let tokenManager: TokenManager
	
	public init(
		tokenManager: TokenManager
	) {
		self.tokenManager = tokenManager
	}
	
	public func execute(userID: Int) {
		tokenManager.save(token: "\(userID)", with: .userID)
	}
}
