//
//  FineListDependency.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/07/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import FineDomain

public protocol FineListDependency: Dependency {
	var fetchFineInfoUseCase: FetchFineInfoUseCase { get }
	var compareUserIDUseCase: CompareUserIDUseCase { get }
	var filterMyFineListUseCase: FilterMyFineListUseCase { get }
}