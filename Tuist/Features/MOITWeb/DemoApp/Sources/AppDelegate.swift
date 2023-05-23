//
//  AppDelegate.swift
//  MOITWebDemoApp
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation
import UIKit
import MOITWeb
import MOITWebImpl
import RIBs

final class MockListener: MOITWebListener {
}
final class MockMOITWebDependencyImpl: MOITWebDependency { }

@main
final class AppDelegate: UIResponder,
                         UIApplicationDelegate {
    
    var window: UIWindow?
    private var webRouter: ViewableRouting?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let builder = MOITWebBuilder(dependency: MockMOITWebDependencyImpl())
        let router = builder.build(withListener: MockListener())
        self.webRouter = router
        router.interactable.activate()
        router.load()
        self.window?.rootViewController = MOITWebDemoRootViewController(rootViewController: router.viewControllable.uiviewController)
        self.window?.makeKeyAndVisible()
        return true
    }
}
