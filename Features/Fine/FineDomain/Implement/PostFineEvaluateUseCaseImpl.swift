//
//  PostFineEvaluateUseCaseImpl.swift
//  FineDomainImpl
//
//  Created by 최혜린 on 2023/07/30.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import FineDomain
import FineData

import RxSwift

public final class PostFineEvaluateUseCaseImpl: PostFineEvaluateUseCase {
	
	private let repository: FineRepository
	
	public init(
		repository: FineRepository
	) {
		self.repository = repository
	}
	
	public func execute(moitID: Int, fineID: Int, data: Data?) -> Single<FineItem?> {
		return repository.postFineEvaluate(
			moitID: moitID,
			fineID: fineID,
			data: data
		)
	}
}
