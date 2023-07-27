//
//  CompareUserIDUseCaseImpl.swift
//  FineDomainImpl
//
//  Created by 최혜린 on 2023/07/27.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import FineDomain
import TokenManager

public final class CompareUserIDUseCaseImpl: CompareUserIDUseCase {
	
	private let tokenManager: TokenManager
	
	public init(
		tokenManager: TokenManager
	) {
		self.tokenManager = tokenManager
	}
	
	public func execute(with iD: Int) -> Bool {
		
		if let myUserID = tokenManager.get(key: .userID) {
			return myUserID == "\(iD)"
		} else {
			return false
		}
	}
}
