//
//  MOITDetailBuilder.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITDetail
import MOITDetailDataImpl
import MOITDetailDomainImpl
import MOITDetailData
import MOITDetailDomain
import MOITDetailDomainImpl
import FineUserInterface
import FineUserInterfaceImpl
import FineDomain
import MOITShareImpl
import MOITShare
import RIBs
import RxRelay

final class MOITDetailComponent: Component<MOITDetailDependency>,
                                 MOITDetailAttendanceDependency,
								 MOITUsersDependency,
								 ShareDependency,
								 FineListDependency,
								 AuthorizePaymentDependency {
	
	var postMasterAuthorizeUseCase: PostMasterAuthorizeUseCase { dependency.postMasterAuthorizeUseCase }
	var fetchFineItemUseCase: FetchFineItemUseCase { dependency.fetchFineItemUseCase }
	
	var convertAttendanceStatusUseCase: ConvertAttendanceStatusUseCase { dependency.convertAttendanceStatusUseCase }
	
	var fetchFineInfoUseCase: FetchFineInfoUseCase { dependency.fetchFineInfoUseCase }
	var compareUserIDUseCase: CompareUserIDUseCase { dependency.compareUserIDUseCase }
	var filterMyFineListUseCase: FilterMyFineListUseCase { dependency.filterMyFineListUseCase }
    var moitDetailUsecase: MOITDetailUsecase { dependency.moitDetailUsecase }
    var moitAllAttendanceUsecase: MOITAllAttendanceUsecase { dependency.moitAllAttendanceUsecase }
    var moitUserusecase: MOITUserUsecase { dependency.moitUserusecase }
	var postFineEvaluateUseCase: PostFineEvaluateUseCase {
		dependency.postFineEvaluateUseCase
	}
    fileprivate let isMasterRelay = PublishRelay<Bool>()
    var isMasterUsecase: CompareUserIDUseCase { compareUserIDUseCase }
}

// MARK: - Builder

public final class MOITDetailBuilder: Builder<MOITDetailDependency>,
                                      MOITDetailBuildable {

    public override init(dependency: MOITDetailDependency) {
        super.init(dependency: dependency)
    }

    public func build(
        withListener listener: MOITDetailListener,
        moitID: String
    ) -> (router: ViewableRouting, actionableItem: MOITDetailActionableItem) {
        
        let component = MOITDetailComponent(dependency: dependency)
        let viewController = MOITDetailViewController()
        
        let interactor = MOITDetailInteractor(
            moitID: moitID,
            tabTypes: [.attendance, .fine],
            presenter: viewController,
            detailUsecase: component.moitDetailUsecase,
            isMasterUsecase: component.isMasterUsecase,
            isMasterRelay: component.isMasterRelay
        )
        interactor.listener = listener
        
        let attendanceBuiler = MOITDetailAttendanceBuilder(dependency: component)
        let moitUserBuilder = MOITUsersBuilder(dependency: component)
		let fineListBuilder = FineListBuilder(dependency: component)
        let shareBuilder = ShareBuilder(dependency: component)
		let authorizePaymentBuilder = AuthorizePaymentBuilder(dependency: component)
        
        let router = MOITDetailRouter(
            interactor: interactor,
            viewController: viewController,
            attendanceBuiler: attendanceBuiler,
            moitUserBuilder: moitUserBuilder,
			fineListBuilder: fineListBuilder,
			shareBuilder: shareBuilder,
			authorizePaymentBuilder: authorizePaymentBuilder
        )
        return (router, interactor)
    }
}
