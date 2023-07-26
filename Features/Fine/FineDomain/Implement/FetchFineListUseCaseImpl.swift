//
//  FetchFineInfoUseCaseImpl.swift
//  FineDomainImpl
//
//  Created by 최혜린 on 2023/07/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import FineDomain
import FineData

import RxSwift

final class FetchFineInfoUseCaseImpl: FetchFineInfoUseCase {
	
	let fineRepository: FineRepository
	
	init(
		fineRepository: FineRepository
	) {
		self.fineRepository = fineRepository
	}
	
	func execute(moitID: String) -> Single<FineInfoEntity> {
		return fineRepository.fetchFineInfo(moitID: moitID)
			.compactMap { FineInfoEntity(fineInfo: $0) }
			.asObservable().asSingle()
	}
}
