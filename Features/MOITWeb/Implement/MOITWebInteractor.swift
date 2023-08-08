//
//  MOITWebInteractor.swift
//  MOITWebImpl
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import WebKit

import MOITWeb
import AuthDomain

import RIBs
import RxSwift


protocol MOITWebRouting: ViewableRouting {
    func routeToShare(invitationCode: String)
    func detachShare()
}

protocol MOITWebPresentable: Presentable {
    var listener: MOITWebPresentableListener? { get set }
	
    func render(domain: String, path: String)
	func showErrorAlert()
}

final class MOITWebInteractor: PresentableInteractor<MOITWebPresentable>,
                                MOITWebInteractable,
							   MOITWebPresentableListener {

    // MARK: - Properties
    
    weak var router: MOITWebRouting?
    weak var listener: MOITWebListener?

    private let domain: String
    private let path: String
    
    // MARK: - LifeCycles
    
    init(
        presenter: MOITWebPresentable,
        domain: String,
        path: String
    ) {
        self.domain = domain
        self.path = path
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        self.presenter.render(domain: self.domain, path: self.path)
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    deinit { debugPrint("\(self) deinit") }
}

// MARK: - MOITWebPresentableListener

extension MOITWebInteractor {
    func didSwipeBack() {
        self.listener?.shouldDetach(withPop: false)
    }
  
	func notRegisteredMemeberDidSignIn(with headerFields: [AnyHashable: Any]) {
		let signInResponse = MOITSignInResponse(headerFields: headerFields)
		debugPrint("---------------------Response---------------------")
		debugPrint(signInResponse)
		listener?.authorizationDidFinish(with: signInResponse)
	}

	func registeredMemberDidSignIn(with headerFields: [AnyHashable: Any]) {
		if let authorizationToken = headerFields ["Authorization"] as? String {
			listener?.didSignIn(with: authorizationToken)
		} else {
			presenter.showErrorAlert()
		}
	}

    func didTapBackButton() {
        self.listener?.shouldDetach(withPop: true)
    }
	
	func didTapErrorAlertOkButton() {
		self.listener?.shouldDetach(withPop: false)
	}
    
    func didTapShare(with code: String) {
        self.router?.routeToShare(invitationCode: code)
    }
}

// MARK: - ShareListener

extension MOITWebInteractor {
    func didTapDimmedView() {
        self.router?.detachShare()
    }
    
    func didSuccessLinkCopy() {
        self.router?.detachShare()
    }
}

// MARK: - MOITWebActionableItem
extension MOITWebInteractor: MOITWebActionableItem {
}
