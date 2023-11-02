//
//  MOITSettingAppDelegate.swift
//
//  MOITSetting
//
//  Created by 송서영 on .
//

import UIKit
import MOITSetting
import MOITSettingImpl
import AuthDomain

import RIBs
import RxSwift

@main
final class MOITSettingAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var router: ViewableRouting?
    
    private final class StubMOITSettingDependency: MOITSettingDependency {
        var userUseCase: UserUseCase = MockUserUseCase()
    }
    
    private final class StubMOITSettingListener: MOITSettingListener {
        func didSwipeBack() {
            print(#function)
        }
        
        func didWithdraw() {
            print(#function)
        }
        
        func didLogout() {
            print(#function)
        }
        
        func didTapBackButton() {
            print(#function)
        }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let builder = MOITSettingBuilder(dependency: StubMOITSettingDependency())
        let router = builder.build(withListener: StubMOITSettingListener())
        self.router = router
        router.load()
        router.interactable.activate()
        window.rootViewController = UINavigationController(rootViewController: router.viewControllable.uiviewController)
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

final class MockUserUseCase: AuthDomain.UserUseCase {
    func logout() -> Single<Void> {
        return .never()
    }
    
    func withdraw() -> Single<Void> {
        return .never()
    }
    
    
}
