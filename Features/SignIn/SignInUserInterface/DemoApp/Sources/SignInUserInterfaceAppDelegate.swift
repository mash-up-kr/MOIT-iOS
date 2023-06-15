//
//  SignInAppDelegate.swift
//
//  SignIn
//
//  Created by hyerin on .
//

import UIKit

@main
final class SignInAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = SignInUserInterfaceViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

