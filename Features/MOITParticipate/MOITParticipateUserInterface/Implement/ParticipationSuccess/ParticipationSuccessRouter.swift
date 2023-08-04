//
//  ParticipationSuccessRouter.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import MOITParticipateUserInterface

protocol ParticipationSuccessInteractable: Interactable {
    var router: ParticipationSuccessRouting? { get set }
    var listener: ParticipationSuccessListener? { get set }
}

protocol ParticipationSuccessViewControllable: ViewControllable { }

final class ParticipationSuccessRouter: ViewableRouter<ParticipationSuccessInteractable, ParticipationSuccessViewControllable>, ParticipationSuccessRouting {

    override init(interactor: ParticipationSuccessInteractable, viewController: ParticipationSuccessViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
	
	deinit { debugPrint("\(self) deinit") }
}
