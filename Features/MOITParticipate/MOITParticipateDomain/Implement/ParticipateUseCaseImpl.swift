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
	public func execute(with code: String) -> Single<MOITParticipateDTO> {
		// ???: 이걸 여기서 만드는게 맞나?! 만드는 위치에 대한 고민...
		let request = MOITParticipateRequest(
			userId: 0,
			invitationCode: code
		)
		return participateRepository.postParticipateCode(with: request)
	}
}
