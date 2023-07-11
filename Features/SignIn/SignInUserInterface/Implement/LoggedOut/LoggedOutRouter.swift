//
//  LoggedOutRouter.swift
//  SignInUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import SignInUserInterface
import Utils
import MOITWeb

protocol LoggedOutInteractable: Interactable, MOITWebListener {
    var router: LoggedOutRouting? { get set }
    var listener: LoggedOutListener? { get set }
}

protocol LoggedOutViewControllable: ViewControllable {
}

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>, LoggedOutRouting {

	private let signInWebBuildable: MOITWebBuildable
	private var signInWebRouting: Routing?
	
    init(
		interactor: LoggedOutInteractable,
		viewController: LoggedOutViewControllable,
		signInWebBuildable: MOITWebBuildable
	) {
		self.signInWebBuildable = signInWebBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
	
	func attachSignInWeb() {
		if signInWebRouting != nil { return }
		
		let router = signInWebBuildable.build(
			withListener: interactor,
			path: .signIn
		)
		viewControllable.present(
			router.viewControllable,
			animated: true,
			completion: nil
		)
		
		signInWebRouting = router
		attachChild(router)
	}
	
	func detachSignInWeb() {
		guard let router = signInWebRouting else { return }
		
		viewControllable.dismiss(completion: nil)
		
		signInWebRouting = nil
		detachChild(router)
	}
}
