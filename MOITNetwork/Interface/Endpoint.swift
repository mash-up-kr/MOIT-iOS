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

	public let baseURL: URL
	public let path: String
	public let method: HTTPMethod
	public let headers: HTTPHeaders
	public let parameters: HTTPRequestParameter?

	public init(
		baseURL: URL = URL(string: "http://moit-backend-eb-env.eba-qtcnkjjy.ap-northeast-2.elasticbeanstalk.com/api/v1/") ?? URL(fileReferenceLiteralResourceName: ""),
		path: String,
		method: HTTPMethod,
		headers: HTTPHeaders = [
			// TODO: 추후 삭제 필요
			"Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqd3QtdXNlci1kZWZhdWx0IiwiYXVkIjoiYXV0aDB8YWJjQG5hdmVyLmNvbXw3fGRlZmF1bHQiLCJpc3MiOiJodHRwczovL2dpdGh1Yi5jb20vbWFzaC11cC1rci9NT0lULWJhY2tlbmQiLCJpYXQiOjE2ODg4ODkyOTMsImV4cCI6MTY5MTQ4MTI5MywiaW5mbyI6eyJpZCI6NywicHJvdmlkZXJVbmlxdWVLZXkiOiJhdXRoMHxhYmNAbmF2ZXIuY29tIiwibmlja25hbWUiOiJkZWZhdWx0IiwicHJvZmlsZUltYWdlIjowLCJlbWFpbCI6ImFiY0BuYXZlci5jb20iLCJyb2xlcyI6WyJVU0VSIl19fQ.o9WjiGqNOZSkHGDKQ54b50TUEy-oWvPo1-5Egjw1HXc",
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
