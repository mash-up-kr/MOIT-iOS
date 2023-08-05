//
//  MOITListDependency.swift
//  MOITListUserInterface
//
//  Created by kimchansoo on 2023/07/15.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITListDomain
import MOITDetailDomain
import MOITParticipateDomain
import FineDomain
import AuthDomain

public protocol MOITListDependency: Dependency {
    var fetchMOITListsUseCase: FetchMoitListUseCase { get }
    var calculateLeftTimeUseCase: CalculateLeftTimeUseCase { get }
    var fetchPaneltyToBePaiedUseCase: FetchBannersUseCase { get }
    var moitDetailUseCase: MOITDetailUsecase { get }
    var moitAllAttendanceUsecase: MOITAllAttendanceUsecase { get }
    var moitUserusecase: MOITUserUsecase { get }
    var moitDetailUsecase: MOITDetailUsecase { get }
    var participateUseCase: ParticipateUseCase { get }
    var compareUserIDUseCase: CompareUserIDUseCase { get }
    var fetchFineInfoUseCase: FetchFineInfoUseCase { get }
    var filterMyFineListUseCase: FilterMyFineListUseCase { get }
    var convertAttendanceStatusUseCase: ConvertAttendanceStatusUseCase { get }
    var fetchFineItemUseCase: FetchFineItemUseCase { get }
    var postFineEvaluateUseCase: PostFineEvaluateUseCase { get }
    var postMasterAuthorizeUseCase: PostMasterAuthorizeUseCase { get }
    var userUseCase: UserUseCase { get }
}
