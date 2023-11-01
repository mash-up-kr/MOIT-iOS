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

import MOITDetailDomain
import MOITDetailDomainImpl
import MOITDetailData
import MOITDetailDataImpl

import ResourceKit
import TokenManagerImpl

import RxSwift
import RIBs
import Toast

final class MockMOITParticipateDependency: InputParticipateCodeDependency {
    
	let network: Network
	let moitDetailUseCase: MOITDetailUsecase
    lazy var participateUseCase: ParticipateUseCase = ParticipateUseCaseImpl(participateRepository: ParticipateRepositoryImpl(network: network), tokenManager: TokenManagerImpl())
    
	init(
		network: Network,
		moitDetailUseCase: MOITDetailUsecase
	) {
		self.network = network
		self.moitDetailUseCase = moitDetailUseCase
	}
}

@main
final class MOITParticipateAppDelegate: UIResponder, UIApplicationDelegate {
		
	private final class MockMOITPariticipateListener: InputParticipateCodeListener {
		func moveToMOITListButtonDidTap() {
			// do nothing
		}
		
		func showMOITDetailButtonDidTap(moitID: Int) {
			// do nothing
		}
		
		func inputParticiateCodeDidTapBack() {
			// do nothing
		}
	}
	
    var window: UIWindow?
	private var router: ViewableRouting?
			
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		let window = UIWindow(frame: UIScreen.main.bounds)
		
		setToastStyle()

		router = InputParticipateCodeBuilder(
			dependency: MockMOITParticipateDependency(network: NetworkImpl(), moitDetailUseCase: MOITDetailUsecaseImpl(repository: MOITDetailRepositoryImpl(network: NetworkImpl())))
		).build(withListener: MockMOITPariticipateListener())
		router?.interactable.activate()
		router?.load()

		window.rootViewController = self.router?.viewControllable.uiviewController
		window.makeKeyAndVisible()
		self.window = window

		return true
	}
}

extension MOITParticipateAppDelegate {
	private func setToastStyle() {
		var style = ToastStyle()
		style.backgroundColor = ResourceKitAsset.Color.gray800.color
		style.cornerRadius = 10
		style.imageSize = CGSize(width: 24, height: 24)
		style.verticalPadding = 20
		style.messageFont = ResourceKitFontFamily.p2
		ToastManager.shared.style = style
		ToastManager.shared.duration = 5.0
	}
}

