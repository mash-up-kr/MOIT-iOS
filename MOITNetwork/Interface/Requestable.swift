//
//  Requestable.swift
//  MOITNetwork
//
//  Created by 최혜린 on 2023/05/15.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPRequestParameter {
	case query([String: String])
	case body(Encodable)
}

public protocol Requestable {
	associatedtype Response: Decodable

	var baseURL: URL { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var headers: HTTPHeaders { get }
	var parameters: HTTPRequestParameter? { get }

	func toURLRequest() throws -> URLRequest
	func makeURL() -> URL?
}

public extension Requestable {
	func toURLRequest() throws -> URLRequest {
		guard let url = makeURL() else { throw NetworkError.invalidURL }
		let urlRequest = URLRequest(url: url)
			.append(method: method)
			.append(body: parameters)
			.append(header: headers)
		return urlRequest
	}

	func makeURL() -> URL? {
		self.baseURL.append(path: path).append(queries: parameters)
	}
}

extension URLRequest {
	func append(method: HTTPMethod) -> URLRequest {
		var request = self
		request.httpMethod = method.rawValue
		return request
	}

	func append(body parameter: HTTPRequestParameter?) -> URLRequest {
		var request = self

		if case .body(let bodyParamters) = parameter {
			let encodedParameters = try? JSONEncoder().encode(bodyParamters)
			request.httpBody = encodedParameters
		}

		return request
	}

	func append(header: HTTPHeaders) -> URLRequest {
		var request = self

		header.forEach { request.setValue($1, forHTTPHeaderField: $0) }

		return request
	}
}

extension URL {
	func append(path: String) -> URL {
		return self.appending(path: path)
	}

	func append(queries parameter: HTTPRequestParameter?) -> URL? {
		var components = URLComponents(string: self.absoluteString)

		if case .query(let queries) = parameter {
			let queryItems = queries.map { URLQueryItem(name: $0, value: $1) }
			components?.queryItems = queryItems
		}

		return components?.url
	}
}
