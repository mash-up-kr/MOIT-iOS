//
//  TTTAppDelegate.swift
//
//  TTT
//
//  Created by 송서영 on .
//

import UIKit

@main
final class TTTAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = TTTUserInterfaceViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

