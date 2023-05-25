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
					
					let result = self.checkError(with: data, response, error)
					
					switch result {
						case .success(let data):
							do {
								let response = try JSONDecoder().decode(E.Response.self, from: data)
								single(.success(response))
							} catch {
								single(.failure(NetworkError.decodingError))
							}
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

	private func checkError(
		with data: Data?,
		_ response: URLResponse?,
		_ error: Error?
	) -> Result<Data,Error> {
		if let error = error {
			return .failure(error)
		}

		guard let response = response as? HTTPURLResponse else {
			return .failure(NetworkError.unknownError)
		}

		guard (200...299).contains(response.statusCode) else {
			let serverError = ServerError(fromRawValue: response.statusCode)
			return .failure(NetworkError.serverError(serverError))
		}

		guard let data = data else {
			return .failure(NetworkError.emptyData)
		}

		return .success(data)
	}
}
