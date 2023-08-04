//
//  LoggedOutRouter.swift
//  SignInUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import AuthUserInterface
import AuthDomain
import AuthUserInterface
import Utils
import MOITWeb

import RxRelay

protocol LoggedOutInteractable: Interactable, MOITWebListener, SignUpListener {
    var router: LoggedOutRouting? { get set }
    var listener: LoggedOutListener? { get set }
}

protocol LoggedOutViewControllable: ViewControllable {
}

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>, LoggedOutRouting {

	private let signInWebBuildable: MOITWebBuildable
	private var signInWebRouting: ViewableRouting?
	
	private let signUpBuildable: SignUpBuildable
	private var signUpRouting: Routing?
	
    init(
		interactor: LoggedOutInteractable,
		viewController: LoggedOutViewControllable,
		signInWebBuildable: MOITWebBuildable,
		signUpBuildable: SignUpBuildable
	) {
		self.signInWebBuildable = signInWebBuildable
		self.signUpBuildable = signUpBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
	
	deinit { debugPrint("\(self) deinit") }
	
	func attachSignInWeb() {
		if signInWebRouting != nil { return }
		
		let router = signInWebBuildable.build(
            withListener: interactor,
            domain: .backend,
			path: .signIn
		)
        
		router.viewControllable.uiviewController.modalPresentationStyle = .overFullScreen
        signInWebRouting = router
        attachChild(router)
        viewControllable.uiviewController.present(
            router.viewControllable.uiviewController,
			animated: true,
			completion: nil
		)
	}
	
	func detachSignInWeb() {
		guard let router = signInWebRouting else { return }
        signInWebRouting = nil
        detachChild(router)
		viewControllable.uiviewController.dismiss(animated: false)
	}
	
	func routeToSignUp(with response: MOITSignInResponse) {
		detachSignInWeb()
		attachSignUp(with: response)
	}
	
	private func attachSignUp(with response: MOITSignInResponse) {
		if signUpRouting != nil { return }
		
		let router = signUpBuildable.build(
			withListener: interactor,
			signInResponse: response
		)
		let viewController = router.viewControllable
		router.viewControllable.uiviewController.modalPresentationStyle = .fullScreen
		
		signUpRouting = router
		attachChild(router)
		
		viewControllable.present(
			viewController,
			animated: true,
			completion: nil
		)
	}
}
