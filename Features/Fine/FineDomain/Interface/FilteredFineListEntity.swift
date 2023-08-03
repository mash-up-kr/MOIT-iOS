//
//  FilteredFineListEntity.swift
//  FineDomain
//
//  Created by 최혜린 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct FilteredFineListEntity {
	public let myFineList: [FineItemEntity]
	public let othersFineList: [FineItemEntity]
	
	public init(
		myFineList: [FineItemEntity],
		othersFineList: [FineItemEntity]
	) {
		self.myFineList = myFineList
		self.othersFineList = othersFineList
	}
}
