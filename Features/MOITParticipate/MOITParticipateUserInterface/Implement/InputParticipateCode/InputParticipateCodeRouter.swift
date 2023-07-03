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

protocol InputParticipateCodeViewControllable: ViewControllable { }

final class InputParticipateCodeRouter: ViewableRouter<InputParticipateCodeInteractable, InputParticipateCodeViewControllable>, InputParticipateCodeRouting {

    override init(interactor: InputParticipateCodeInteractable, viewController: InputParticipateCodeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
