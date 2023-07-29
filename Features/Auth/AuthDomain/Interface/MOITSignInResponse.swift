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
	public let providerUniqueKey: String
	public let nickname: String
	public let email: String
	
	public init(
		headerFields: [AnyHashable : Any]
	) {
		self.providerUniqueKey = headerFields["X-MOIT-USER-PROVIDER"] as? String ?? ""
		self.nickname = headerFields["X-MOIT-USER-NICKNAME"]  as? String ?? ""
		self.email = headerFields["X-MOIT-USER-EMAIL"]  as? String ?? ""
	}
}
