//
//  MainAppDelegate.swift
//
//  Main
//
//  Created by kimchansoo on .
//

import UIKit

@main
final class DesignSystemAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.rootViewController = UINavigationController(rootViewController: DesignSystemViewController())
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
