//
//  SaveTokenUseCaseImpl.swift
//  AuthDomainImpl
//
//  Created by 최혜린 on 2023/07/27.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthDomain
import TokenManager

public final class SaveTokenUseCaseImpl: SaveTokenUseCase {
	
	private let tokenManager: TokenManager
	
	public init(
		tokenManager: TokenManager
	) {
		self.tokenManager = tokenManager
	}
	
	public func execute(token: String) {
		tokenManager.save(token: token, with: .authorizationToken)
	}
}
