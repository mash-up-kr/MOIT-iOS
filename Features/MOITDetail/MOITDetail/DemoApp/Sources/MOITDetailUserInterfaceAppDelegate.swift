//
//  MOITDetailAppDelegate.swift
//
//  MOITDetail
//
//  Created by 송서영 on .
//

import UIKit
import MOITDetail
import MOITDetailImpl
import RIBs

@main
final class MOITDetailAppDelegate: UIResponder,
                                   UIApplicationDelegate {
    
    private final class MockMOITDetailDependency: MOITDetailDependency {
        
    }
    
    private final class MOCKMOITDetailListener: MOITDetailListener {
        
    }
    
    var window: UIWindow?
    private var router: ViewableRouting?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
     
        self.router = MOITDetailBuilder(dependency: MockMOITDetailDependency())
            .build(withListener: MOCKMOITDetailListener())
        
        self.router?.load()
        self.router?.interactable.activate()
        
        self.window?.rootViewController = self.router?.viewControllable.uiviewController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

