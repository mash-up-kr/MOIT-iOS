//
//  MOITListRouter.swift
//  MOITListUserInterfaceImpl
//
//  Created by kimchansoo on 2023/06/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITListUserInterface

import RIBs

protocol MOITListInteractable: Interactable {
    var router: MOITListRouting? { get set }
    var listener: MOITListListener? { get set }
}

protocol MOITListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MOITListRouter: ViewableRouter<MOITListInteractable, MOITListViewControllable>, MOITListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MOITListInteractable, viewController: MOITListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
