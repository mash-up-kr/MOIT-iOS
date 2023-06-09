//
//  MOITDetailRouter.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

protocol MOITDetailInteractable: Interactable {
    var router: MOITDetailRouting? { get set }
    var listener: MOITDetailListener? { get set }
}

protocol MOITDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MOITDetailRouter: ViewableRouter<MOITDetailInteractable, MOITDetailViewControllable>, MOITDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MOITDetailInteractable, viewController: MOITDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
