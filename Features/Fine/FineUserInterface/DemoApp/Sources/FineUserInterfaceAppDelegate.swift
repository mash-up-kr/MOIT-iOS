//
//  FineAppDelegate.swift
//
//  Fine
//
//  Created by hyerin on .
//

import UIKit

import FineUserInterface
import FineUserInterfaceImpl

import RIBs

@main
final class FineAppDelegate: UIResponder, UIApplicationDelegate {
	
	private final class MockFineDependency: FineListDependency { }
	
	private final class MockFineListener: FineListListener { }
	
    var window: UIWindow?
	
	private var router: ViewableRouting?
	
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
		router = FineListBuilder(dependency: MockFineDependency())
			.build(withListener: MockFineListener())
		router?.interactable.activate()
		router?.load()

		window.rootViewController = self.router?.viewControllable.uiviewController
		window.makeKeyAndVisible()
		self.window = window
		
        return true
    }
}

