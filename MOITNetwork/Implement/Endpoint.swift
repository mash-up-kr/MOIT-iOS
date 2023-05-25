//
//  Endpoint.swift
//  MOITNetworkImpl
//
//  Created by 최혜린 on 2023/05/25.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation
import MOITNetwork

public final class EndPoint<R>: Requestable where R: Decodable {
	public typealias Response = R
	
	public var baseURL: URL?
	public var path: String?
	public var method: HTTPMethod
	public var headers: HTTPHeaders
	public var parameters: HTTPRequestParameter?
	
	public init(
		baseURL: URL?,
		path: String?,
		method: HTTPMethod,
		headers: HTTPHeaders,
		parameters: HTTPRequestParameter?
	) {
		self.baseURL = baseURL
		self.path = path
		self.method = method
		self.headers = headers
		self.parameters = parameters
	}
}
