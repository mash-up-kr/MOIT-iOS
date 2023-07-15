//
//  FineListRouter.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import FineUserInterface

protocol FineListInteractable: Interactable, AuthorizePaymentListener {
    var router: FineListRouting? { get set }
    var listener: FineListListener? { get set }
}

protocol FineListViewControllable: ViewControllable { }

final class FineListRouter: ViewableRouter<FineListInteractable, FineListViewControllable>, FineListRouting {

	private let authorizePaymentBuildable: AuthorizePaymentBuildable
	private var authorizePaymentRouting: Routing?
	
    init(
		authorizePaymentBuildable: AuthorizePaymentBuildable,
		interactor: FineListInteractable,
		viewController: FineListViewControllable
	) {
		self.authorizePaymentBuildable = authorizePaymentBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
	
	func attachAuthorizePayment() {
		if authorizePaymentRouting != nil { return }
		
		let router = authorizePaymentBuildable.build(withListener: interactor)
		let viewController = router.viewControllable.uiviewController
		viewController.modalPresentationStyle = .fullScreen
		viewControllable.uiviewController.present(viewController, animated: true)
	
		authorizePaymentRouting = router
		attachChild(router)
	}
	
	func detachAuthorizePayment() {
		guard let router = authorizePaymentRouting else { return }
		
		viewControllable.uiviewController.dismiss(animated: true)
		detachChild(router)
		authorizePaymentRouting = nil
	}
}
