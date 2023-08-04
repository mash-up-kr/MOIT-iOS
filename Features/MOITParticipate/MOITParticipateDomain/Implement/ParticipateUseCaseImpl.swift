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
	public func execute(with code: String) -> Single<ParticipateEntity> {
		// ???: 이걸 여기서 만드는게 맞나?! 만드는 위치에 대한 고민...
		// TODO: userId 불러오는 로직 추가 필요
		let request = MOITParticipateRequest(
			userId: 10,
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
