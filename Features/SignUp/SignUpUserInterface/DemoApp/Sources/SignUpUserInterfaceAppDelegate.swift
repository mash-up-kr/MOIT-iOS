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
    var router: ViewableRouting?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ProfileSelectViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
        return true
        
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        
//        let signUpBuilder = SignUpBuilder(dependency: MOCKSignUpComponent())
//        self.router = signUpBuilder.build(withListener: MOCKMOITSignUpListener())
////        let launchRouter = LaunchRouter(interactor: router, viewController: router.viewControllable)
//        router?.load()
//        router?.interactable.activate() // TODO: - 이 녀석의 정체는?!
//        window.rootViewController = router?.viewControllable.uiviewController
//
//        window.makeKeyAndVisible()
//        self.window = window
//        return true
    }
    
    private final class MOCKMOITSignUpListener: SignUpListener {}
}


