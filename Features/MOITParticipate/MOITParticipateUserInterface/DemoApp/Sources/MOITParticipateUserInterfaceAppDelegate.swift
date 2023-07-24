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
import ResourceKit

import RxSwift
import RIBs
import Toast

final class MockMOITParticipateDependency: InputParticipateCodeDependency {
	var network: Network
	
	init(
		network: Network
	) {
		self.network = network
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
		
		setToastStyle()

		router = InputParticipateCodeBuilder(
			dependency: MockMOITParticipateDependency(network: NetworkImpl())
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
	// TODO: 추후 setting 위치 변경 필요
	private func setToastStyle() {
		var style = ToastStyle()
		style.backgroundColor = ResourceKitAsset.Color.gray800.color
		style.cornerRadius = 10
		style.imageSize = CGSize(width: 24, height: 24)
		style.horizontalPadding = 20
		style.messageFont = ResourceKitFontFamily.p2
		// TODO: 노출시간 변경되는 경우 세팅필요함
		//		style.fadeDuration =
		ToastManager.shared.style = style
	}
}

