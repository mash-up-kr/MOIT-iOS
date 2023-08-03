//
//  FilterMyFineListUseCaseImpl.swift
//  FineDomainImpl
//
//  Created by 최혜린 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import FineDomain
import TokenManager

public final class FilterMyFineListUseCaseImpl: FilterMyFineListUseCase {
	
	private let tokenManager: TokenManager
	
	public init(
		tokenManager: TokenManager
	) {
		self.tokenManager = tokenManager
	}
	
	public func execute(
		fineList: [FineItemEntity]
	) -> FilteredFineListEntity {
		if let myUserIDString = tokenManager.get(key: .userID), let myUserID = Int(myUserIDString) {
			return FilteredFineListEntity(
				myFineList: fineList.filter { $0.userID == myUserID },
				othersFineList: fineList.filter { $0.userID != myUserID }
			)
		} else {
			return FilteredFineListEntity(myFineList: [], othersFineList: fineList)
		}
	}
	
	
}
