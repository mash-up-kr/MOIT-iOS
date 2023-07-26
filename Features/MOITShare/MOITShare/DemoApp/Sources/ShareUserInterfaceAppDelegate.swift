//
//  ShareAppDelegate.swift
//
//  Share
//
//  Created by 송서영 on .
//

import UIKit

@main
final class ShareAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ShareUserInterfaceViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

