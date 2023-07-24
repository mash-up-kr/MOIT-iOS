//
//  ParticipateUseCaseImpl.swift
//  MOITParticipateDomain
//
//  Created by 최혜린 on 2023/07/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITParticipateData
import MOITParticipateDomain

import RxSwift

public final class ParticipateUseCaseImpl: ParticipateUseCase {
	
// MARK: - properties
	private let participateRepository: ParticipateRepository
	
// MARK: - init
	public init(
		participateRepository: ParticipateRepository
	) {
		self.participateRepository = participateRepository
	}
	
// MARK: - public
	public func execute(with request: MOITParticipateRequest) -> Single<MOITParticipateDTO> {
		participateRepository.postParticipateCode(with: request)
	}
}
