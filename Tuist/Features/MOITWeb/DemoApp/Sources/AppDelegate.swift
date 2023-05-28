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
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(
            rootViewController: MOITWebDemoRootViewController()
        )
        self.window?.makeKeyAndVisible()
        return true
    }
}
