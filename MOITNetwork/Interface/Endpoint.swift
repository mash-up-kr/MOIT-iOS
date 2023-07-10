//
//  Endpoint.swift
//  MOITNetwork
//
//  Created by 최혜린 on 2023/05/25.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation

public struct Endpoint<R>: Requestable where R: Decodable {
	public typealias Response = R

	public let baseURL: URL?
	public let path: String
	public let method: HTTPMethod
	public let headers: HTTPHeaders
	public let parameters: HTTPRequestParameter?

	public init(
		baseURL: URL? = URL(string: "http://moit-backend-eb-env.eba-qtcnkjjy.ap-northeast-2.elasticbeanstalk.com/api/v1/"),
		path: String,
		method: HTTPMethod,
		headers: HTTPHeaders = [
			"authorization" : "",
			"Content-Type": "application/json"
		],
		parameters: HTTPRequestParameter? = nil
	) {
		self.baseURL = baseURL
		self.path = path
		self.method = method
		self.headers = headers
		self.parameters = parameters
	}
}
