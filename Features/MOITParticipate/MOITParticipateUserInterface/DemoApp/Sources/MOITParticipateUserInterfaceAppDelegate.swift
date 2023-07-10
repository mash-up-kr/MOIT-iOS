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
import MOITParticipateData
import MOITParticipateDataImpl
import MOITParticipateDomain
import MOITParticipateDomainImpl
import MOITNetwork
import MOITNetworkImpl

import RxSwift
import RIBs

final class MockMOITParticipateDependency: InputParticipateCodeDependency {
	var participateUseCase: ParticipateUseCase
	
	init(
		participateUseCase: ParticipateUseCase
	) {
		self.participateUseCase = participateUseCase
	}
}

@main
final class MOITParticipateAppDelegate: UIResponder, UIApplicationDelegate {
		
	private final class MockMOITPariticipateListener: InputParticipateCodeListener { }
	
    var window: UIWindow?
	private var router: ViewableRouting?
			
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		let window = UIWindow(frame: UIScreen.main.bounds)
		
		let participateRepository = ParticipateRepositoryImpl(network: NetworkImpl())
		
		let participateUseCase = ParticipateUseCaseImpl(
			participateRepository: participateRepository
		)
		
		router = InputParticipateCodeBuilder(
			dependency: MockMOITParticipateDependency(participateUseCase: participateUseCase)
		).build(withListener: MockMOITPariticipateListener())
		router?.interactable.activate()
		router?.load()

		window.rootViewController = self.router?.viewControllable.uiviewController
		window.makeKeyAndVisible()
		self.window = window

		return true
	}
}

