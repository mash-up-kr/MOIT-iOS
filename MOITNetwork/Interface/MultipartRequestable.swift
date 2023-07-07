//
//  MultipartRequestable.swift
//  MOITNetwork
//
//  Created by 최혜린 on 2023/05/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol MultipartRequestable: Requestable {
	var formData: MultipartFormData { get }
}

public extension MultipartRequestable {
	var method: HTTPMethod {
		.post
	}

	func toURLRequest() throws -> URLRequest {
		guard let url = makeURL() else { throw NetworkError.invalidURL }

		var urlRequest = URLRequest(url: url)
			.append(method: method)
			.append(header: headers)
			.append(multiPartData: formData.body)

		urlRequest.setValue("multipart/form-data; boundary=\(formData.boundary)", forHTTPHeaderField: "Content-Type")

		return urlRequest
	}
}

extension URLRequest {
	func append(multiPartData: NSMutableData) -> URLRequest {
		var request = self
		request.httpBody = multiPartData as Data
		return request
	}
}
