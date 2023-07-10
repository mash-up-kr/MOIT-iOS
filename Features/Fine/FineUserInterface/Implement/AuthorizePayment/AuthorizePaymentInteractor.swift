//
//  AuthorizePaymentInteractor.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import FineUserInterface

import RIBs
import RxSwift

protocol AuthorizePaymentRouting: ViewableRouting { }

protocol AuthorizePaymentPresentable: Presentable {
    var listener: AuthorizePaymentPresentableListener? { get set }
}

final class AuthorizePaymentInteractor: PresentableInteractor<AuthorizePaymentPresentable>, AuthorizePaymentInteractable, AuthorizePaymentPresentableListener {

    weak var router: AuthorizePaymentRouting?
    weak var listener: AuthorizePaymentListener?

    override init(presenter: AuthorizePaymentPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
	
	func dismissButtonDidTap() {
		listener?.authorizePaymentDismissButtonDidTap()
	}
}
