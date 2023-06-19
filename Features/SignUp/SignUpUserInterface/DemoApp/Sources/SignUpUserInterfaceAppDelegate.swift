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
final class SignUpAppDelegate: UIResponder, UIApplicationDelegate, SignUpListener {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let signUpBuilder = SignUpBuilder(dependency: MOCKSignUpComponent())
        let router = signUpBuilder.build(withListener: MOCKMOITSignUpListener())
//        let launchRouter = LaunchRouter(interactor: router, viewController: router.viewControllable)
        router.load()
        window.rootViewController = router.viewControllable.uiviewController

        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    private final class MOCKMOITSignUpListener: SignUpListener {}
}


