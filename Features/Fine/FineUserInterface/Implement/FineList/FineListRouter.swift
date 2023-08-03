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
	
	func attachAuthorizePayment(
		moitID: Int,
		fineID: Int,
		isMaster: Bool
	) {
		if authorizePaymentRouting != nil { return }
		
		let router = authorizePaymentBuildable.build(
			withListener: interactor,
			moitID: moitID,
			fineID: fineID,
			isMaster: isMaster
		)
		let viewController = router.viewControllable.uiviewController
		viewController.modalPresentationStyle = .fullScreen
		viewControllable.uiviewController.present(viewController, animated: true)
	
		authorizePaymentRouting = router
		attachChild(router)
	}
	
	func detachAuthorizePayment(completion: (() -> Void)?) {
		guard let router = authorizePaymentRouting else { return }
		
		viewControllable.uiviewController.dismiss(
			animated: true,
			completion: {
				if let completion {
					completion()
				}
			}
		)
		detachChild(router)
		authorizePaymentRouting = nil
	}
}
