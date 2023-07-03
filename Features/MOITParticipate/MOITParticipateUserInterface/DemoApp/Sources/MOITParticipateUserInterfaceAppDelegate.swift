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
		with endpoint: Endpoint<MOITParticipateDTO>
	) -> Single<MOITParticipateDTO> {
		
		let response = MOITParticipateDTO(moitId: 0)
		
		return Observable.just(response).asSingle()
	}
}

@main
final class MOITParticipateAppDelegate: UIResponder, UIApplicationDelegate {
	
	private final class MockMOITParticipateDependency: InputParticipateCodeDependency {
		var participateUseCase: ParticipateUseCase
		
		init(
			participateUseCase: ParticipateUseCase
		) {
			self.participateUseCase = participateUseCase
		}
	}
	
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

