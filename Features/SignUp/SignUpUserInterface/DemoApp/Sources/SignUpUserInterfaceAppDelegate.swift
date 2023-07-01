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
import DesignSystem

import RIBs

@main
final class SignUpAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var router: ViewableRouting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)

        let signUpBuilder = SignUpBuilder(dependency: MOCKSignUpComponent())
        self.router = signUpBuilder.build(withListener: MOCKMOITSignUpListener())

        router?.load()
        router?.interactable.activate()
        window.rootViewController = router?.viewControllable.uiviewController

        window.makeKeyAndVisible()
        self.window = window
        return true
    }

    private final class MOCKMOITSignUpListener: SignUpListener {}
}
