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
//	public func execute(imageIndex: Int, name: String, inviteCode: String?) -> Single<Int> {
//		return participateRepository.postParticipateCode(with: )
//	}
}
