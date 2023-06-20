//
//  MOITParticipateAppDelegate.swift
//
//  MOITParticipate
//
//  Created by hyerin on .
//

import UIKit

import MOITParticipateUserInterface
import MOITParticipateUserInterfaceImpl

import RIBs

@main
final class MOITParticipateAppDelegate: UIResponder, UIApplicationDelegate {
	
	private final class MockMOITParticipateDependency: InputParticipateCodeDependency { }
	
	private final class MockMOITPariticipateListener: InputParticipateCodeListener { }
	
    var window: UIWindow?
	
	private var router: ViewableRouting?
		
		func application(
			_ application: UIApplication,
			didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
		) -> Bool {
			let window = UIWindow(frame: UIScreen.main.bounds)
			
			router = InputParticipateCodeBuilder(dependency: MockMOITParticipateDependency())
				.build(withListener: MockMOITPariticipateListener())
			router?.load()
			router?.interactable.activate()

			window.rootViewController = self.router?.viewControllable.uiviewController
			window.makeKeyAndVisible()
			self.window = window

			return true
		}
}
