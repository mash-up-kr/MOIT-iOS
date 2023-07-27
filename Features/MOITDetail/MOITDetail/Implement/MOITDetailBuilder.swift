//
//  MOITDetailBuilder.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITDetail
import MOITDetailData
import MOITDetailDomain
import FineUserInterface
import FineUserInterfaceImpl
import FineDomain

import RIBs

final class MOITDetailComponent: Component<MOITDetailDependency>,
                                 MOITDetailAttendanceDependency,
								 MOITUsersDependency,
								 FineListDependency {
	
	var fetchFineInfoUseCase: FetchFineInfoUseCase { dependency.fetchFineInfoUseCase }
	var compareUserIDUseCase: CompareUserIDUseCase { dependency.compareUserIDUseCase }
	
    var moitDetailRepository: MOITDetailRepository { dependency.moitDetailRepository }
    var moitAllAttendanceUsecase: MOITAllAttendanceUsecase { dependency.moitAttendanceUsecase }
    var moitUserusecase: MOITUserUsecase { dependency.moitUserusecase }
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
    ) -> ViewableRouting {
        
        let component = MOITDetailComponent(dependency: dependency)
        let viewController = MOITDetailViewController()
        
        let interactor = MOITDetailInteractor(
            moitID: moitID,
            tabTypes: [.attendance, .fine],
            presenter: viewController,
            detailUsecase: dependency.moitDetailUsecase
        )
        interactor.listener = listener
        
        let attendanceBuiler = MOITDetailAttendanceBuilder(dependency: component)
        let moitUserBuilder = MOITUsersBuilder(dependency: component)
		let fineListBuilder = FineListBuilder(dependency: component)
        
        return MOITDetailRouter(
            interactor: interactor,
            viewController: viewController,
            attendanceBuiler: attendanceBuiler,
            moitUserBuilder: moitUserBuilder,
			fineListBuilder: fineListBuilder
        )
    }
}
