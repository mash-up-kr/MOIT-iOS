//
//  MOITDetailBuilder.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITDetail
import MOITDetailDomainImpl
import MOITDetailDataImpl
import MOITDetailData

final class MOITDetailComponent: Component<MOITDetailDependency>,
                                 MOITDetailAttendanceDependency {
    lazy var moitDetailRepository: MOITDetailRepository = MOITDetailRepositoryImpl(network: dependency.network)
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
        let detailUsecase = MOITDetailUsecaseImpl(repository: component.moitDetailRepository)
        
        let interactor = MOITDetailInteractor(
            moitID: moitID,
            tabTypes: [.attendance, .fine],
            presenter: viewController,
            detailUsecase: detailUsecase
        )
        interactor.listener = listener
        
        let attendanceBuiler = MOITDetailAttendanceBuilder(dependency: component)
        
        return MOITDetailRouter(
            interactor: interactor,
            viewController: viewController,
            attendanceBuiler: attendanceBuiler
        )
    }
}
