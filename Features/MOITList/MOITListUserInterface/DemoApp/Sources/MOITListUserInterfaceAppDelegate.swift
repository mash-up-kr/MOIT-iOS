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
            .build(withListener: MOCKMOITListListener())
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
        var calculateLeftTimeUseCase: CalculateLeftTimeUseCase
        
        var fetchPaneltyToBePaiedUseCase: FetchBannersUseCase
        
        var fetchMOITListsUseCase: FetchMoitListUseCase
        
        init() {
            self.fetchMOITListsUseCase = FetchMoitListUseCaseImpl(moitRepository: MOITRepositoryImpl(network: NetworkImpl()))
//            self.fetchMOITListsUseCase = FetchMoitListUseCaseImpl(moitRepository: MockMoitRepository())
            self.fetchPaneltyToBePaiedUseCase = MockBannersUseCase()
            self.calculateLeftTimeUseCase = CalculateLeftTimeUseCaseImpl()
            super.init(dependency: EmptyComponent())
        }
    }
    
    private final class MOCKMOITListListener: MOITListListener {
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
