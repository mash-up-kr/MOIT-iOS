//
//  FetchFineItemUseCaseImpl.swift
//  FineDomainImpl
//
//  Created by 최혜린 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import FineDomain
import FineData

import RxSwift

public final class FetchFineItemUseCaseImpl: FetchFineItemUseCase {
	
	private let fineRepository: FineRepository
	
	public init(
		fineRepository: FineRepository
	) {
		self.fineRepository = fineRepository
	}
	
	public func execute(
		moitID: Int,
		fineID: Int
	) -> Single<FineItemEntity> {
		return fineRepository.fetchFineItem(
			moitID: moitID,
			fineID: fineID
		)
		.compactMap { fineItem -> FineItemEntity? in
			return FineItemEntity(fineItem: fineItem)
		}
		.asObservable().asSingle()
		
	}
	
}
