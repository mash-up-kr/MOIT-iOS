//
//  AuthorizePaymentDependency.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import FineDomain
import MOITDetailDomain

import RIBs

public protocol AuthorizePaymentDependency: Dependency {
	var fetchFineItemUseCase: FetchFineItemUseCase { get }
	var convertAttendanceStatusUseCase: ConvertAttendanceStatusUseCase { get }
	var compareUserIDUseCase: CompareUserIDUseCase { get }
}
