//
//  NetworkImpl.swift
//  MOITNetworkImpl
//
//  Created by 최혜린 on 2023/05/15.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation

import MOITNetwork
import CSLogger

import RxSwift

public final class NetworkImpl: Network {

    public static let shared = NetworkImpl()
	private let session: URLSession

	public init(session: URLSession = URLSession.shared) {
		self.session = session
	}

	public func request<E>(with endpoint: E) -> Single<E.Response> where E: Requestable {
		do {
			var urlRequest = try endpoint.toURLRequest()
            
            let token = """
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqd3QtdXNlci1kZWZhdWx0IiwiYXVkIjoiYXV0aDB8YWJjQG5hdmVyLmNvbXw3fGRlZmF1bHQiLCJpc3MiOiJodHRwczovL2dpdGh1Yi5jb20vbWFzaC11cC1
"""
            let token2 = """
rci9NT0lULWJhY2tlbmQiLCJpYXQiOjE2ODg4ODkyOTMsImV4cCI6MTY5MTQ4MTI5MywiaW5mbyI6eyJpZCI6NywicHJvdmlkZXJVbmlxdWVLZXkiOiJhdXRoMHxhYmNAbmF2ZXIuY
"""
            let token3 = """
29tIiwibmlja25hbWUiOiJkZWZhdWx0IiwicHJvZmlsZUltYWdlIjowLCJlbWFpbCI6ImFiY0BuYXZlci5jb20iLCJyb2xlcyI6WyJVU0VSIl19fQ.o9WjiGqNOZSkHGDKQ54b50TUEy-oWvPo1-5Egjw1HXc
"""
            urlRequest.setValue("Bearer \(token)\(token2)\(token3)", forHTTPHeaderField: "Authorization")
            
			Logger.debug("requested url: \(urlRequest.url)")
			Logger.debug(
				"header: \(urlRequest.value(forHTTPHeaderField: "authorization") ?? "")"
			)
			Logger.debug(
				"requested httpBody: \(String(decoding: urlRequest.httpBody ?? Data(), as: UTF8.self))"
			)

			return Single.create { [weak self] single in
				self?.session.dataTask(with: urlRequest) { [weak self] data, response, error in
					guard let self else { return }
					let result = self.checkError(with: data, response, error, E.Response.self)

					switch result {
					case .success(let response):
						Logger.debug("👍 success: \(response)")
						
						single(.success(response))
					case .failure(let error):
						Logger.debug("💥 error: \(error)")
						
						single(.failure(error))
					}
				}.resume()
				return Disposables.create()
			}
		} catch {
			return .error(NetworkError.invalidURL)
		}
	}
    
    deinit { debugPrint("\(self) deinit") }

	private func checkError<M: Decodable>(
		with data: Data?,
		_ response: URLResponse?,
		_ error: Error?,
		_ model: M.Type
	) -> Result<M, Error> {
		if let error = error {
			return .failure(error)
		}

		guard let response = response as? HTTPURLResponse else {
			return .failure(NetworkError.unknownError)
		}
		
		guard let data = data else {
			return .failure(NetworkError.emptyData)
		}
		
		Logger.debug("🧐 response data: \(String(decoding: data, as: UTF8.self))")
		Logger.debug("👀 statusCode: \(response.statusCode)")

		do {
			let responseModel = try JSONDecoder().decode(MOITResponse<M>.self, from: data)
			
			if responseModel.success, let data = responseModel.data {
				return .success(data)
			} else {
				let serverError = ServerError(fromRawValue: response.statusCode)
				return .failure(NetworkError.serverError(serverError))
			}
		} catch {
			return .failure(NetworkError.decodingError)
		}
	}
}
