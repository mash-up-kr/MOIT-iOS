//
//  MOITAlarmAppDelegate.swift
//
//  MOITAlarm
//
//  Created by 송서영 on .
//

import UIKit
import MOITAlarmImpl
import MOITAlarm
import MOITAlarmDomain
import MOITAlarmDomainImpl
import MOITAlarmData

import RIBs
import RxSwift

@main
final class MOITAlarmAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private var router: ViewableRouting?
    
    private final class StubMOITAlarmDependency: MOITAlarmDependency {
        var fetchNotificationUseCase: FetchNotificationListUseCase = FetchNotificationListUseCaseImpl(repository: MockMoitAlarmRepository())
    }
    
    private final class StubMOITAlarmListener: MOITAlarmListener {
        func didSwipeBackAlarm() { }
        
        func didTapBackAlarm() { }
        
        func didTapAlarm(scheme: String) { }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let router = MOITAlarmBuilder(
            dependency: StubMOITAlarmDependency()
        ).build(withListener: StubMOITAlarmListener())
        self.router = router
        router.interactable.activate()
        router.load()
        window.rootViewController = router.viewControllable.uiviewController
        
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

final class MockMoitAlarmRepository: MOITAlarmRepository {
    func fetchNotificationList() -> Single<NotificationModel> {
        return .never()
    }
    
}
