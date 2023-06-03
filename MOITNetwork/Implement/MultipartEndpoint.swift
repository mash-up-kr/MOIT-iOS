//
//  MultipartEndpoint.swift
//  MOITNetworkImpl
//
//  Created by 최혜린 on 2023/05/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITNetwork

public final class MultipartEndpoint<R>: MultipartRequestable where R: Decodable {

	public typealias Response = R

	public let baseURL: URL
	public let path: String?
	public let method: HTTPMethod
	public let headers: HTTPHeaders
	public let parameters: HTTPRequestParameter?
	public let formData: MultipartFormData

	public init(
		baseURL: URL,
		path: String? = nil,
		method: HTTPMethod,
		headers: HTTPHeaders,
		parameters: HTTPRequestParameter? = nil,
		formData: MultipartFormData
	) {
		self.baseURL = baseURL
		self.path = path
		self.method = method
		self.headers = headers
		self.parameters = parameters
		self.formData = formData
	}
}
