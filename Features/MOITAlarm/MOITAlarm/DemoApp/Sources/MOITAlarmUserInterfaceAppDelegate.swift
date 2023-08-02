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
import RIBs

@main
final class MOITAlarmAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private var router: ViewableRouting?
    
    private final class StubMOITAlarmDependency: MOITAlarmDependency {
        
    }
    private final class StubMOITAlarmListener: MOITAlarmListener {
        
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
