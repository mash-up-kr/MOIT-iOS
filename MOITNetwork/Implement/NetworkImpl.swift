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
			let urlRequest = try endpoint.toURLRequest()

			return Single.create { [weak self] single in
				self?.session.dataTask(with: urlRequest) { [weak self] data, response, error in
					guard let self else { return }
					let result = self.checkError(with: data, response, error, E.Response.self)

					switch result {
					case .success(let response):
						print("""
                        --------------------    success  ----------------------
                        👍 url: \(urlRequest.url!)
                        👍 header: \(urlRequest.value(forHTTPHeaderField: "Authorization") ?? "")
                        👍 body: \(String(decoding: urlRequest.httpBody ?? Data(), as: UTF8.self))
                        👍 success: \(response)
                        --------------------------------------------------------
                        """)
						
						single(.success(response))
					case .failure(let error):
                        print("""
                        ----------------------   error  ------------------------
                        💥 url: \(urlRequest.url!)
                        💥 header: \(urlRequest.value(forHTTPHeaderField: "Authorization") ?? "")
                        💥 body: \(String(decoding: urlRequest.httpBody ?? Data(), as: UTF8.self))
                        💥 error: \(error)
                        --------------------------------------------------------
                        """)
						
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

		do {
			let responseModel = try JSONDecoder().decode(MOITResponse<M>.self, from: data)
			print(data)
			if responseModel.success, let data = responseModel.data {
				return .success(data)
			} else {
				let serverError = ServerError(fromRawValue: response.statusCode)
				return .failure(NetworkError.serverError(serverError))
			}
		} catch {
            return .failure(NetworkError.decodingError(code: response.statusCode))
		}
	}
}
