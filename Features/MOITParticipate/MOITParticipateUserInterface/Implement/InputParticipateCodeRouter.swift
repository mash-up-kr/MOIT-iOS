//
//  InputParticipateCodeRouter.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import MOITParticipateUserInterface

protocol InputParticipateCodeInteractable: Interactable {
    var router: InputParticipateCodeRouting? { get set }
    var listener: InputParticipateCodeListener? { get set }
}

protocol InputParticipateCodeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class InputParticipateCodeRouter: ViewableRouter<InputParticipateCodeInteractable, InputParticipateCodeViewControllable>, InputParticipateCodeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: InputParticipateCodeInteractable, viewController: InputParticipateCodeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
