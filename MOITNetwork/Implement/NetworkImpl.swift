//
//  NetworkImpl.swift
//  MOITNetworkImpl
//
//  Created by 최혜린 on 2023/05/15.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation
import MOITNetwork
import RxSwift

public final class NetworkImpl: Network {

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
						single(.success(response))
					case .failure(let error):
						single(.failure(error))
					}
				}.resume()
				return Disposables.create()
			}
		} catch {
			return .error(NetworkError.invalidURL)
		}
	}

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
			
			if responseModel.success {
				return .success(responseModel.data)
			} else {
				let serverError = ServerError(fromRawValue: response.statusCode)
				return .failure(NetworkError.serverError(serverError))
			}
		} catch {
			return .failure(NetworkError.decodingError)
		}
	}
}
