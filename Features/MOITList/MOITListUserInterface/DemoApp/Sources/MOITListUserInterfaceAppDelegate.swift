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
        var fetchLeftTimeUseCase: FetchLeftTimeUseCase
        
        var fetchPaneltyToBePaiedUseCase: FetchPenaltyToBePaidUseCase
        
        var fetchMOITListsUseCase: FetchMoitListUseCase
        
        init() {
            self.fetchMOITListsUseCase = FetchMoitListUseCaseImpl(moitRepository: MockMoitRepository())
            self.fetchLeftTimeUseCase = MockFetchLeftTimeUseCase()
            self.fetchPaneltyToBePaiedUseCase = MockFetchPenaltyToBePaidUseCase()
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
    
    private final class MockFetchPenaltyToBePaidUseCase: FetchPenaltyToBePaidUseCase {
        func execute() -> Single<Int> {
            return Single.just(1000)
        }
    }
    
    private final class MockFetchLeftTimeUseCase: FetchLeftTimeUseCase {
        func execute(moitList: [MOIT]) -> (moitName: String, time: Date) {
            return ("전전자군단", Date())
        }
    }
    
    
}
