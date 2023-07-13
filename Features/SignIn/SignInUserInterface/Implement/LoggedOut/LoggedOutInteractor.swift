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
//	func attachSignUp()
//	func detachSignUp()
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
	
	func shouldDetach(withPop: Bool) {
		router?.detachSignInWeb()
	}
	
// MARK: - MOITWeb
//	func attachSignUp(with signInResponse: MOITSignInResponse) {
//		router?.attachSignUp()
//	}
//
//	func attachStudyList() {
//		router.
//	}
}
