//
//  MOITUsersRouter.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/07/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

protocol MOITUsersInteractable: Interactable {
    var router: MOITUsersRouting? { get set }
    var listener: MOITUsersListener? { get set }
}

protocol MOITUsersViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MOITUsersRouter: ViewableRouter<MOITUsersInteractable, MOITUsersViewControllable>, MOITUsersRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MOITUsersInteractable, viewController: MOITUsersViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
