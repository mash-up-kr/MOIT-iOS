//
//  InputParticipateCodeRouter.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import MOITParticipateUserInterface
import MOITDetail

protocol InputParticipateCodeInteractable: Interactable, ParticipationSuccessListener {
    var router: InputParticipateCodeRouting? { get set }
    var listener: InputParticipateCodeListener? { get set }
}

protocol InputParticipateCodeViewControllable: ViewControllable { }

final class InputParticipateCodeRouter: ViewableRouter<InputParticipateCodeInteractable,
										InputParticipateCodeViewControllable>,
										InputParticipateCodeRouting {

	private let participationSuccessBuildable: ParticipationSuccessBuildable
	private var participationSuccessRouting: Routing?
	
    init(
		interactor: InputParticipateCodeInteractable,
		viewController: InputParticipateCodeViewControllable,
		participationSuccessBuildable: ParticipationSuccessBuildable
	) {
		self.participationSuccessBuildable = participationSuccessBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
	
	deinit { debugPrint("\(self) deinit") }
	
	func attachPariticipationSuccess(with viewModel: MOITDetailProfileInfoViewModel) {
		if participationSuccessRouting != nil {
			return
		}
		
		let router = participationSuccessBuildable.build(
			withListener: interactor,
			withViewModel: viewModel
		)
		
		let participationSuccessViewController = router.viewControllable.uiviewController
		participationSuccessViewController.modalPresentationStyle = .fullScreen
		
		self.viewController.uiviewController.navigationController?.present(participationSuccessViewController, animated: true)
		participationSuccessRouting = router
		attachChild(router)
	}
	
	func detachPariticipationSuccess() {
		guard let router = participationSuccessRouting else { return }
		
		viewController.uiviewController.dismiss(animated: true)
		participationSuccessRouting = nil
		detachChild(router)
	}
}
