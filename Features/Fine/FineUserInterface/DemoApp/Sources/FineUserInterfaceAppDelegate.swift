//
//  FineAppDelegate.swift
//
//  Fine
//
//  Created by hyerin on .
//

import UIKit

@main
final class FineAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = FineUserInterfaceViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

