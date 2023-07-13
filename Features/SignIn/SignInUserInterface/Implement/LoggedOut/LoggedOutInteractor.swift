//
//  LoggedOutInteractor.swift
//  SignInUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift

import SignInUserInterface
import MOITWeb

protocol LoggedOutRouting: ViewableRouting {
	func attachSignInWeb()
	func detachSignInWeb()
	func routeToSignUp(with response: MOITSignInResponse)
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {

    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?

    override init(presenter: LoggedOutPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
	
	func kakaoSignInButtonDidTap() {
		router?.attachSignInWeb()
	}
	
	func appleSignInButtonDidTap() {
//		CSLogger.Logger.debug("appleSignIn")
	}
	
	
	
// MARK: - MOITWeb
	func shouldDetach(withPop: Bool) {
		router?.detachSignInWeb()
	}

	func authorizationDidFinish(with signInResponse: MOITSignInResponse) {
		// TODO: ? 이게 맞나 . . . ...?
		router?.routeToSignUp(with: signInResponse)
	}
//
//	func attachStudyList() {
//		router.
//	}
}
