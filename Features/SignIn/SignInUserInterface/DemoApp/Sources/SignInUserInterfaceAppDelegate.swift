//
//  SignInAppDelegate.swift
//
//  SignIn
//
//  Created by hyerin on .
//

import UIKit

import SignInUserInterface
import SignInUserInterfaceImpl

import RIBs

@main
final class SignInAppDelegate: UIResponder, UIApplicationDelegate {
	
	private final class MockSignInDependency: LoggedOutDependency {
		
	}
	
	private final class MockSignInListener: LoggedOutListener {
		
	}
	
    var window: UIWindow?
	
	private var router: ViewableRouting?
	
    func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
		
		router = LoggedOutBuilder(dependency: MockSignInDependency())
			.build(withListener: MockSignInListener())
		router?.load()
		router?.interactable.activate()

		window.rootViewController = self.router?.viewControllable.uiviewController
		window.makeKeyAndVisible()
		self.window = window

		return true
    }
}

