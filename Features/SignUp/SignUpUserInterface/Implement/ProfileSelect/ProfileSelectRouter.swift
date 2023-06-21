//
//  ProfileSelectRouter.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/21.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import SignUpUserInterface

import RIBs

protocol ProfileSelectInteractable: Interactable {
    var router: ProfileSelectRouting? { get set }
    var listener: ProfileSelectListener? { get set }
}

protocol ProfileSelectViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ProfileSelectRouter: ViewableRouter<ProfileSelectInteractable, ProfileSelectViewControllable>, ProfileSelectRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ProfileSelectInteractable, viewController: ProfileSelectViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
