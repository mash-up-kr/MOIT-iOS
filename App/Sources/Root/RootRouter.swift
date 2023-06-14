//
//  RootRouter.swift
//  App
//
//  Created by 송서영 on 2023/05/22.
//

import RIBs

protocol RootInteractable: Interactable {
    var router: RootRouting? { get set }
}

protocol RootViewControllable: ViewControllable {
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>,
                        RootRouting {
    
    override init(
        interactor: RootInteractable,
        viewController: RootViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    deinit { debugPrint("\(self) deinit") }
}
