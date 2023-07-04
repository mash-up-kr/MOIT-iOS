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
import MOITParticipateDomain
import MOITParticipateDomainImpl
import MOITNetwork

import RxSwift
import RIBs

final class MockParticipateRepository: ParticipateRepository {
	func postParticipateCode(
		with request: MOITParticipateRequest
	) -> Single<MOITParticipateDTO> {
		
		let response = MOITParticipateDTO(moitId: 0)
		return Observable.just(response).asSingle()
	}
}

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
		
		let participateUseCase = ParticipateUseCaseImpl(
			participateRepository: MockParticipateRepository()
		)
		
		router = InputParticipateCodeBuilder(
			dependency: MockMOITParticipateDependency(participateUseCase: participateUseCase)
		).build(withListener: MockMOITPariticipateListener())
		router?.load()
		router?.interactable.activate()

		window.rootViewController = self.router?.viewControllable.uiviewController
		window.makeKeyAndVisible()
		self.window = window

		return true
	}
}

