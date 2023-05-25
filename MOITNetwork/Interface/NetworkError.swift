//
//  NetworkError.swift
//  MOITNetwork
//
//  Created by 최혜린 on 2023/05/15.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
	case unknownError
	case invalidURL
	case decodingError
	case emptyData
	case serverError(ServerError)
}

public enum ServerError: Int {
	case unknownError
	case badReqeust = 400
	case notFount = 404
	
	public init(fromRawValue rawValue: Int) {
		self = ServerError(rawValue: rawValue) ?? .unknownError
	}
}
