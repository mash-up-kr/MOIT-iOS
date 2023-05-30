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
	
	public var baseURL: URL?
	public var path: String?
	public var method: HTTPMethod
	public var headers: HTTPHeaders
	public var parameters: HTTPRequestParameter?
	public var formData: MultipartFormData
	
	public init(
		baseURL: URL?,
		path: String?,
		method: HTTPMethod,
		headers: HTTPHeaders,
		parameters: HTTPRequestParameter?,
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
