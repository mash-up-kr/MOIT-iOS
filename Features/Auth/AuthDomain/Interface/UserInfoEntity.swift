//
//  UserInfoEntity.swift
//  AuthDomainImpl
//
//  Created by 최혜린 on 2023/07/28.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthData

public struct UserInfoEntity {
	public let userID: Int
	public let nickname: String
	public let email: String
	
	public init(
		userID: Int,
		nickname: String,
		email: String
	) {
		self.userID = userID
		self.nickname = nickname
		self.email = email
	}
}
