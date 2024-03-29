//
//  ParticipateRepositoryImpl.swift
//  MOITParticipateDataImpl
//
//  Created by 최혜린 on 2023/07/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITParticipateData
import MOITDetailData
import MOITNetwork

import RxSwift

public final class ParticipateRepositoryImpl: ParticipateRepository {
	
	private let network: Network
		
	public init(network: Network) {
		self.network = network
	}
	
	public func postParticipateCode(
		with request: MOITParticipateRequest
	) -> Single<ParticipateResponseDTO> {
		let endpoint = ParticipateEndpoint.postParticipateCode(with: request)
		return network.request(with: endpoint)
			.compactMap { $0 }.asObservable().asSingle()
	}
}
