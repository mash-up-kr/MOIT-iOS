//
//  MOITSignInResponse.swift
//  MOITWeb
//
//  Created by 최혜린 on 2023/07/12.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOITSignInResponse {
	let providerUniqueKey: String
	let nickname: String
	let email: String
	
	public init(
		cookieList: [String: String]
	) {
		self.providerUniqueKey = cookieList["providerUniqueKey"] ?? ""
		self.nickname = cookieList["nickname"] ?? ""
		self.email = cookieList["email"] ?? ""
	}
}
