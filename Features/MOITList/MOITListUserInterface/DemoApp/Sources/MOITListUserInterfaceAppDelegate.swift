//
//  MOITListAppDelegate.swift
//
//  MOITList
//
//  Created by kimchansoo on .
//

import UIKit

import MOITListUserInterface
import MOITListUserInterfaceImpl
import MOITListDomain
import MOITListDomainImpl
import MOITListData
import MOITListDataImpl
import MOITNetwork
import MOITNetworkImpl

import MOITDetailDomain
import MOITDetailDomainImpl
import MOITDetailData
import MOITDetailDataImpl

import FineDomain
import FineDomainImpl
import FineData
import FineDataImpl

import MOITParticipateDomain
import MOITParticipateDomainImpl
import MOITParticipateData
import MOITParticipateDataImpl

import AuthDomain
import AuthDomainImpl
import AuthData
import AuthDataImpl

import MOITAlarmDomain
import MOITAlarmDomainImpl
import MOITAlarmData
import MOITAlarmDataImpl

import TokenManager
import TokenManagerImpl


import RxSwift
import RIBs

@main
final class MOITListAppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var router: ViewableRouting?
    let dependency = MockMoitListComponent()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.router = MOITListBuilder(dependency: dependency)
            .build(withListener: MOCKMOITListListener()).0
        self.router?.load()
        self.router?.interactable.activate()
        window.rootViewController = self.router?.viewControllable.uiviewController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

extension MOITListAppDelegate {
    
    final class MockMoitListComponent: Component<EmptyDependency>,
                                       MOITListDependency
    {
        lazy var network = NetworkImpl()
        lazy var moitDetailRepository = MOITDetailRepositoryImpl(network: network)
        lazy var fineRepository = FineRepositoryImpl(network: network)
        lazy var userRepository = UserRepositoryImpl(network: network)
        lazy var participateRepository = ParticipateRepositoryImpl(network: network)
        lazy var tokenManager = TokenManagerImpl()
        
        lazy var moitDetailUseCase: MOITDetailDomain.MOITDetailUsecase = MOITDetailUsecaseImpl(repository: moitDetailRepository)
        
        lazy var participateUseCase: MOITParticipateDomain.ParticipateUseCase = ParticipateUseCaseImpl(participateRepository: participateRepository, tokenManager: tokenManager)
        
        lazy var compareUserIDUseCase: FineDomain.CompareUserIDUseCase = CompareUserIDUseCaseImpl(tokenManager: tokenManager)
        
        lazy var fetchFineInfoUseCase: FineDomain.FetchFineInfoUseCase = FetchFineInfoUseCaseImpl(fineRepository: fineRepository)
        
        lazy var filterMyFineListUseCase: FineDomain.FilterMyFineListUseCase = FilterMyFineListUseCaseImpl(tokenManager: tokenManager)
        
        lazy var convertAttendanceStatusUseCase: MOITDetailDomain.ConvertAttendanceStatusUseCase = ConvertAttendanceStatusUseCaseImpl()
        
        lazy var fetchFineItemUseCase: FineDomain.FetchFineItemUseCase = FetchFineItemUseCaseImpl(fineRepository: fineRepository)
        
        lazy var postFineEvaluateUseCase: FineDomain.PostFineEvaluateUseCase = PostFineEvaluateUseCaseImpl(repository: fineRepository)
        
        lazy var postMasterAuthorizeUseCase: FineDomain.PostMasterAuthorizeUseCase = PostMasterAuthorizeUseCaseImpl(repository: fineRepository)
        
        lazy var userUseCase: AuthDomain.UserUseCase = UserUseCaseImpl(userRepository: userRepository, tokenManager: tokenManager)
        
        lazy var fetchNotificationUseCase: MOITAlarmDomain.FetchNotificationListUseCase = FetchNotificationListUseCaseImpl(repository: MOITAlarmRepositoryImpl(network: network))
        
        let detailRepository = MOITDetailRepositoryImpl(network: NetworkImpl())
        lazy var moitAllAttendanceUsecase: MOITAllAttendanceUsecase = MOITAllAttendanceUsecaseImpl(repository: detailRepository)
        
        lazy var moitUserusecase: MOITUserUsecase = MOITUserUsecaseImpl(repository: detailRepository)
        
        var moitDetailUsecase: MOITDetailUsecase = MOITDetailUsecaseImpl(repository: MOITDetailRepositoryImpl(network: NetworkImpl()))
        
        var calculateLeftTimeUseCase: CalculateLeftTimeUseCase
        
        var fetchPaneltyToBePaiedUseCase: FetchBannersUseCase
        
        var fetchMOITListsUseCase: FetchMoitListUseCase
        
        init() {
            self.fetchMOITListsUseCase = FetchMoitListUseCaseImpl(moitRepository: MOITRepositoryImpl(network: NetworkImpl()))

            self.fetchPaneltyToBePaiedUseCase = MockBannersUseCase()
            self.calculateLeftTimeUseCase = CalculateLeftTimeUseCaseImpl()
            
            super.init(dependency: EmptyComponent())
        }
    }
    
    private final class MOCKMOITListListener: MOITListListener {
        func didLogout() {
            print(#function)
        }
        
        func didWithdraw() {
            print(#function)
        }
        
        func didTapAlarm(scheme: String) {
            print(#function)
        }
        
    }
    
    private final class MockMoitRepository: MOITRepository {
        
        func fetchMOITList() -> Single<[MOIT]> {
            return Single.just([
                MOIT(
                    id: 1,
                    name: "hi",
                    profileUrl: "hi",
                    isEnd: true,
                    repeatCycle: "hi",
                    dayOfWeeks: ["hi"],
                    startTime: "hi",
                    endTime: "hi",
                    dday: 1
                ),
                MOIT(
                    id: 1,
                    name: "hi",
                    profileUrl: "hi",
                    isEnd: true,
                    repeatCycle: "hi",
                    dayOfWeeks: ["hi"],
                    startTime: "hi",
                    endTime: "hi",
                    dday: 1
                )
            ])
        }
        
        func deleteMoit(id: Int) -> Single<Void> {
            fatalError()
        }
    }
    
    private final class MockBannersUseCase: FetchBannersUseCase {
        func execute() -> Single<[Banner]> {
            Single.just([Banner.fine(FineBanner(
                userId: 1,
                moitId: 1,
                moitName: "전전전자군단",
                fineAmount: 9000
            ))])
        }
    }
    
    
}
