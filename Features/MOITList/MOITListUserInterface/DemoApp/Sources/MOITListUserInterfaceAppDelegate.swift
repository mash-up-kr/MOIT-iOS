//
//  MOITListAppDelegate.swift
//
//  MOITList
//
//  Created by kimchansoo on .
//

import UIKit

@main
final class MOITListAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MOITListUserInterfaceViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

