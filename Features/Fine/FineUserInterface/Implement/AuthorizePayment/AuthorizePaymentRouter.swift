//
//  AuthorizePaymentRouter.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import FineUserInterface

protocol AuthorizePaymentInteractable: Interactable {
    var router: AuthorizePaymentRouting? { get set }
    var listener: AuthorizePaymentListener? { get set }
}

protocol AuthorizePaymentViewControllable: ViewControllable { }

final class AuthorizePaymentRouter: ViewableRouter<AuthorizePaymentInteractable, AuthorizePaymentViewControllable>, AuthorizePaymentRouting {

    override init(interactor: AuthorizePaymentInteractable, viewController: AuthorizePaymentViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
