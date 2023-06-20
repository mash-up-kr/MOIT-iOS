//
//  Response.swift
//  MOITNetwork
//
//  Created by 최혜린 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOITErrorResponse: Decodable {
	let code: String
	let message: String
}

public struct MOITResponse<R>: Decodable where R: Decodable {
	public let success: Bool
	public let data: R?
	public let error: MOITErrorResponse?
}
