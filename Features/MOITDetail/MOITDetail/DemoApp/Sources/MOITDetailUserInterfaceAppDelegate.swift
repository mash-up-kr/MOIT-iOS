//
//  MOITDetailAppDelegate.swift
//
//  MOITDetail
//
//  Created by 송서영 on .
//

import UIKit
import MOITDetail
import MOITDetailImpl
import MOITNetworkImpl
import MOITNetwork
import RIBs
import MOITDetailDomain
import MOITDetailDomainImpl
import MOITDetailDataImpl
import MOITDetailData
import RxSwift

@main
final class MOITDetailAppDelegate: UIResponder,
                                   UIApplicationDelegate,
                                   MOITDetailListener {
    final class MockMOITDetailDependency: MOITDetailDependency {
        var tabTypes: [MOITDetailTab] = [.attendance, .fine]
        var moitDetailRepository: MOITDetailRepository = MOITDetailRepositoryImpl(network: NetworkImpl())
        var moitDetailUsecase: MOITDetailUsecase { MOITDetailUsecaseImpl(repository: moitDetailRepository) }
        var moitAttendanceUsecase: MOITAllAttendanceUsecase { StubMOITAllAttendanceUsecase() }
//        var moitAttendanceUsecase: MOITAllAttendanceUsecase { MOITAllAttendanceUsecaseImpl(repository: moitDetailRepository) }
        var moitUserusecase: MOITUserUsecase { MOITUserUsecaseImpl(repository: moitDetailRepository) }
//        var moitUserusecase: MOITUserUsecase {
//            StubMOITUserUsecase()
//        }
    }
    
    var window: UIWindow?
    private var router: ViewableRouting?
    let dependency = MockMOITDetailDependency()
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let router = MOITDetailBuilder(dependency: dependency)
            .build(withListener: self, moitID: "2")
        self.router = router
        self.router?.load()
        self.router?.interactable.activate()
        let navigation = UINavigationController(rootViewController: router.viewControllable.uiviewController)
        window.rootViewController = navigation

        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
