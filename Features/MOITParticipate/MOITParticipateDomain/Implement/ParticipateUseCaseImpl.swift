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
import MOITDetailDomain
import TokenManager

import RxSwift

public final class ParticipateUseCaseImpl: ParticipateUseCase {
	
// MARK: - properties
	private let participateRepository: ParticipateRepository
	private let tokenManager: TokenManager
	
// MARK: - init
	public init(
		participateRepository: ParticipateRepository,
		tokenManager: TokenManager
	) {
		self.participateRepository = participateRepository
		self.tokenManager = tokenManager
	}
	
// MARK: - public
	public func execute(with code: String) -> Single<ParticipateEntity> {
		
		let userIDString: String = tokenManager.get(key: .userID) ?? "0"
		let userID = Int(userIDString) ?? 0
		
		let request = MOITParticipateRequest(
			userId: userID,
			invitationCode: code
		)
		
		return participateRepository.postParticipateCode(with: request)
			.compactMap { [weak self] participateResponseDTO -> ParticipateEntity? in
				guard let self else { return nil}
				return self.convertToParticipateEntity(from: participateResponseDTO)
			}
			.asObservable()
			.asSingle()
	}
	
	private func convertToParticipateEntity(
		from response: ParticipateResponseDTO
	) -> ParticipateEntity {
		return ParticipateEntity(
			moitID: response.moitID,
			moitName: response.name,
			description: response.description,
			imageURL: response.imageURL,
			scheduleDayOfWeeks: response.scheduleDayOfWeeks,
			scheduleRepeatCycle: response.scheduleRepeatCycle,
			scheduleStartTime: response.scheduleStartTime,
			scheduleEndTime: response.scheduleEndTime,
			fineLateTime: response.fineLateTime,
			fineLateAmount: response.fineLateAmount,
			fineAbsenceTime: response.fineAbsenceTime,
			fineAbsenceAmount: response.fineAbsenceAmount,
			notificationIsRemindActive: response.notificationIsRemindActive,
			notificationRemindOption: response.notificationRemindOption,
			startDate: response.startDate,
			endDate: response.endDate
		)
	}
}
