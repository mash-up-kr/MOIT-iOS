//
//  MOITListBuilder.swift
//  MOITListUserInterfaceImpl
//
//  Created by kimchansoo on 2023/06/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITListUserInterface
import MOITListDomain
import MOITDetailDomain
import MOITDetail
import MOITWebImpl
import MOITWeb
import RIBs
import MOITDetailImpl

final class MOITListComponent: Component<MOITListDependency>,
                               MOITListInteractorDependency,
                               MOITWebDependency,
                               MOITDetailDependency {
    var moitAllAttendanceUsecase: MOITAllAttendanceUsecase { dependency.moitAllAttendanceUsecase }
    var moitUserusecase: MOITUserUsecase { dependency.moitUserusecase }
    var moitDetailUsecase: MOITDetailUsecase { dependency.moitDetailUsecase }
    
    var calculateLeftTimeUseCase: CalculateLeftTimeUseCase { dependency.calculateLeftTimeUseCase }
    
    var fetchBannersUseCase: FetchBannersUseCase { dependency.fetchPaneltyToBePaiedUseCase }
    
    var fetchMOITListsUseCase: FetchMoitListUseCase { dependency.fetchMOITListsUseCase }
}

// MARK: - Builder

public final class MOITListBuilder: Builder<MOITListDependency>, MOITListBuildable {
    
    public override init(dependency: MOITListDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: MOITListListener) -> ViewableRouting {
        let component = MOITListComponent(dependency: dependency)
        let viewController = MOITListViewController()
        let interactor = MOITListInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        
        let moitWebBuilder = MOITWebBuilder(dependency: component)
        let moitDetailBuilder = MOITDetailBuilder(dependency: component)
        
        return MOITListRouter(
            interactor: interactor,
            viewController: viewController,
            moitWebBuilder: moitWebBuilder,
            moitDetailBuilder: moitDetailBuilder
        )
    }
}
