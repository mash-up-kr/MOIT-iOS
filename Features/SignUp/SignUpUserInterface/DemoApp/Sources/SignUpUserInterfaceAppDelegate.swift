//
//  SignUpAppDelegate.swift
//
//  SignUp
//
//  Created by kimchansoo on .
//

import UIKit

import SignUpUserInterfaceImpl
import SignUpUserInterface

import RIBs

@main
final class SignUpAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        

        // RIBs 사용해서 signupbuilder로 build 실행
//         window.rootViewController = SignUpBuilder(dependency: AppComponent()).build()
        window.rootViewController = SignUpViewController()
        
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

