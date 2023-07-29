//
//  MOITSettingAppDelegate.swift
//
//  MOITSetting
//
//  Created by 송서영 on .
//

import UIKit
import MOITSetting
import MOITSettingImpl
import RIBs

@main
final class MOITSettingAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var router: ViewableRouting?
    
    private final class StubMOITSettingDependency: MOITSettingDependency {
    }
    private final class StubMOITSettingListener: MOITSettingListener {
        func didTapBackButton() {
            print(#function)
        }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let builder = MOITSettingBuilder(dependency: StubMOITSettingDependency())
        let router = builder.build(withListener: StubMOITSettingListener())
        self.router = router
        router.load()
        router.interactable.activate()
        window.rootViewController = UINavigationController(rootViewController: router.viewControllable.uiviewController)
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

