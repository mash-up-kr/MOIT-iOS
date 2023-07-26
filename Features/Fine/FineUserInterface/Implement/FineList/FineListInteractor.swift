//
//  FineListInteractor.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift

import FineUserInterface
import FineDomain

protocol FineListRouting: ViewableRouting {
	func attachAuthorizePayment()
	func detachAuthorizePayment()
}

protocol FineListPresentable: Presentable {
    var listener: FineListPresentableListener? { get set }
}

public protocol FineListInteractorDependency {
	var fetchFineInfoUsecase: FetchFineInfoUseCase { get }
}

final class FineListInteractor: PresentableInteractor<FineListPresentable>, FineListInteractable, FineListPresentableListener {

    weak var router: FineListRouting?
    weak var listener: FineListListener?
	
	private let dependency: FineListInteractorDependency

    init(
		presenter: FineListPresentable,
		dependency: FineListInteractorDependency
	) {
		self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
	
	func fineListDidTap(with fineItem: FineItem) {
		router?.attachAuthorizePayment()
	}
	
	func authorizePaymentDismissButtonDidTap() {
		router?.detachAuthorizePayment()
	}
}
