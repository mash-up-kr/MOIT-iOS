//
//  MOITListAppDelegate.swift
//
//  MOITList
//
//  Created by kimchansoo on .
//

import UIKit

import MOITListUserInterface
import MOITListUserInterfaceImpl

import RIBs

@main
final class MOITListAppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var router: ViewableRouting?
    let dependency = MockMOITListDependency()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.router = MOITListBuilder(dependency: dependency)
            .build(withListener: MOCKMOITListListener())
        self.router?.load()
        self.router?.interactable.activate()
        window.rootViewController = self.router?.viewControllable.uiviewController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
}

extension MOITListAppDelegate {

    final class MockMOITListDependency:  MOITListDependency {
        
    }
    private final class MOCKMOITListListener: MOITListListener {
    }
}
