//
//  FineListRouter.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import FineUserInterface

protocol FineListInteractable: Interactable {
    var router: FineListRouting? { get set }
    var listener: FineListListener? { get set }
}

protocol FineListViewControllable: ViewControllable { }

final class FineListRouter: ViewableRouter<FineListInteractable, FineListViewControllable>, FineListRouting {

    override init(interactor: FineListInteractable, viewController: FineListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
