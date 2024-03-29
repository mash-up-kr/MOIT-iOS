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
import MOITSetting
import MOITSettingImpl
import MOITParticipateUserInterface
import MOITParticipateUserInterfaceImpl
import MOITParticipateDomain
import MOITAlarm
import MOITAlarmImpl
import MOITAlarmDomain
import FineDomain
import AuthDomain

final class MOITListComponent: Component<MOITListDependency>,
                               MOITListInteractorDependency,
                               MOITWebDependency,
                               MOITDetailDependency,
                               InputParticipateCodeDependency,
                               MOITSettingDependency,
							   MOITAlarmDependency {
	var fetchNotificationUseCase: FetchNotificationListUseCase { dependency.fetchNotificationUseCase }
    var userUseCase: UserUseCase { dependency.userUseCase }
    var compareUserIDUseCase: CompareUserIDUseCase { dependency.compareUserIDUseCase }
    var fetchFineInfoUseCase: FetchFineInfoUseCase { dependency.fetchFineInfoUseCase }
    var filterMyFineListUseCase: FilterMyFineListUseCase { dependency.filterMyFineListUseCase }
    var convertAttendanceStatusUseCase: ConvertAttendanceStatusUseCase { dependency.convertAttendanceStatusUseCase }
    var fetchFineItemUseCase: FetchFineItemUseCase { dependency.fetchFineItemUseCase}
    var postFineEvaluateUseCase: PostFineEvaluateUseCase { dependency.postFineEvaluateUseCase }
    var postMasterAuthorizeUseCase: PostMasterAuthorizeUseCase { dependency.postMasterAuthorizeUseCase }
    
    var participateUseCase: ParticipateUseCase { dependency.participateUseCase }
    
    
    var moitAllAttendanceUsecase: MOITAllAttendanceUsecase { dependency.moitAllAttendanceUsecase }
    var moitUserusecase: MOITUserUsecase { dependency.moitUserusecase }
    var moitDetailUsecase: MOITDetailUsecase { dependency.moitDetailUsecase }
    
    var calculateLeftTimeUseCase: CalculateLeftTimeUseCase { dependency.calculateLeftTimeUseCase }
    
    var fetchBannersUseCase: FetchBannersUseCase { dependency.fetchPaneltyToBePaiedUseCase }
    
    var fetchMOITListsUseCase: FetchMoitListUseCase { dependency.fetchMOITListsUseCase }
    var moitDetailUseCase: MOITDetailUsecase { dependency.moitDetailUseCase }
}

// MARK: - Builder

public final class MOITListBuilder: Builder<MOITListDependency>, MOITListBuildable {
    
    public override init(dependency: MOITListDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: MOITListListener) -> (ViewableRouting, MOITListActionableItem) {
        let component = MOITListComponent(dependency: dependency)
        let viewController = MOITListViewController()
        let interactor = MOITListInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        
        let moitWebBuilder = MOITWebBuilder(dependency: component)
        let moitDetailBuilder = MOITDetailBuilder(dependency: component)
        let inputParticipateCodeBuilder = InputParticipateCodeBuilder(dependency: component)
        let settingBuilder = MOITSettingBuilder(dependency: component)
		let alarmBuilder = MOITAlarmBuilder(dependency: component)
        
        let router = MOITListRouter(
            interactor: interactor,
            viewController: viewController,
            moitWebBuilder: moitWebBuilder,
            moitDetailBuilder: moitDetailBuilder,
            inputParticipateCodeBuilder: inputParticipateCodeBuilder,
            settingBuilder: settingBuilder,
			alarmBuilder: alarmBuilder
        )
        return (router, interactor)
    }
}
