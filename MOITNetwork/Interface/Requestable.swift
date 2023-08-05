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
//            .append(header: headers)
        // TODO: 지워야됨!!
            .append(header: ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqd3QtdXNlci1kZWZhdWx0IiwiYXVkIjoiYXV0aDB8YWJjQG5hdmVyLmNvbXw3fGRlZmF1bHQiLCJpc3MiOiJodHRwczovL2dpdGh1Yi5jb20vbWFzaC11cC1rci9NT0lULWJhY2tlbmQiLCJpYXQiOjE2ODg4ODkyOTMsImV4cCI6MTY5MTQ4MTI5MywiaW5mbyI6eyJpZCI6NywicHJvdmlkZXJVbmlxdWVLZXkiOiJhdXRoMHxhYmNAbmF2ZXIuY29tIiwibmlja25hbWUiOiJkZWZhdWx0IiwicHJvZmlsZUltYWdlIjowLCJlbWFpbCI6ImFiY0BuYXZlci5jb20iLCJyb2xlcyI6WyJVU0VSIl19fQ.o9WjiGqNOZSkHGDKQ54b50TUEy-oWvPo1-5Egjw1HXc"])
		return urlRequest
	}

	func makeURL() -> URL? {
		self.baseURL.append(path: path).append(queries: parameters)
	}
    
    var baseURL: URL {
		URL(string: "http://moit-backend-eb-env.eba-qtcnkjjy.ap-northeast-2.elasticbeanstalk.com") ?? URL(fileReferenceLiteralResourceName: "")
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
        if #available(iOS 16.0, *) {
            return self.appending(path: path)
        } else {
            // TODO: 혜린언니 여기 수정 ~~ 부탁드립니다
            return URL.init(fileReferenceLiteralResourceName: "")
        }
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
