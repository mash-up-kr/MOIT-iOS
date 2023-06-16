//
//  ParticipationSuccessRouter.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

protocol ParticipationSuccessInteractable: Interactable {
    var router: ParticipationSuccessRouting? { get set }
    var listener: ParticipationSuccessListener? { get set }
}

protocol ParticipationSuccessViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ParticipationSuccessRouter: ViewableRouter<ParticipationSuccessInteractable, ParticipationSuccessViewControllable>, ParticipationSuccessRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ParticipationSuccessInteractable, viewController: ParticipationSuccessViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
