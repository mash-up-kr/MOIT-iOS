//
//  MOITDetailDependency.swift
//  MOITDetail
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITNetwork
import RIBs
import MOITDetailDomain
import MOITDetailData
import FineDomain

public protocol MOITDetailDependency: Dependency {
    var tabTypes: [MOITDetailTab] { get }
    var moitDetailUsecase: MOITDetailUsecase { get }
    var moitAttendanceUsecase: MOITAllAttendanceUsecase { get }
    var moitDetailRepository: MOITDetailRepository { get }
    var fetchFineInfoUsecase: FetchFineInfoUseCase { get }
}
