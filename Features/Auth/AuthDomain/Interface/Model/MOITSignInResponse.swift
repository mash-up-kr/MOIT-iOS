//
//  MOITSignInResponse.swift
//  MOITWeb
//
//  Created by 최혜린 on 2023/07/12.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import WebKit

public struct MOITSignInResponse {
	let providerUniqueKey: String
	let nickname: String
	let email: String
	
	public init(
		headerFields: [AnyHashable : Any]
	) {
		self.providerUniqueKey = headerFields["X-MOIT-User-Provider"] as? String ?? ""
		self.nickname = headerFields["X-MOIT-User-Nickname"]  as? String ?? ""
		self.email = headerFields["X-MOIT-User-Email"]  as? String ?? ""
	}
}
