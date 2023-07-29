//
//  MOITListDependency.swift
//  MOITListUserInterface
//
//  Created by kimchansoo on 2023/07/15.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
//import MOITNetwork
import MOITListDomain
import MOITDetailDomain

public protocol MOITListDependency: Dependency {
//    var network: Network { get }
    var fetchMOITListsUseCase: FetchMoitListUseCase { get }
    var calculateLeftTimeUseCase: CalculateLeftTimeUseCase { get }
    var fetchPaneltyToBePaiedUseCase: FetchBannersUseCase { get }
    var moitDetailUseCase: MOITDetailUsecase { get }
    var moitAllAttendanceUsecase: MOITAllAttendanceUsecase { get }
    var moitUserusecase: MOITUserUsecase { get }
    var moitDetailUsecase: MOITDetailUsecase { get }
}
