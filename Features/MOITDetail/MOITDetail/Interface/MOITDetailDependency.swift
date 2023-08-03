//
//  MOITDetailDependency.swift
//  MOITDetail
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITDetailDomain
import MOITDetailData
import FineDomain

import RIBs

public protocol MOITDetailDependency: Dependency {
    
    var moitAllAttendanceUsecase: MOITAllAttendanceUsecase { get }
    var moitUserusecase: MOITUserUsecase { get }
	var compareUserIDUseCase: CompareUserIDUseCase { get }
	var fetchFineInfoUseCase: FetchFineInfoUseCase { get }
	var filterMyFineListUseCase: FilterMyFineListUseCase { get }
	var convertAttendanceStatusUseCase: ConvertAttendanceStatusUseCase { get }
	var fetchFineItemUseCase: FetchFineItemUseCase { get }
	var postFineEvaluateUseCase: PostFineEvaluateUseCase { get }
	var postMasterAuthorizeUseCase: PostMasterAuthorizeUseCase { get }
    var moitDetailUsecase: MOITDetailUsecase { get }
}
