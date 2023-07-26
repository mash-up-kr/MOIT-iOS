//
//  AuthorizePaymentBuilder.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import FineUserInterface

import RIBs

protocol AuthorizePaymentDependency: Dependency { }

final class AuthorizePaymentComponent: Component<AuthorizePaymentDependency> { }

// MARK: - Builder

final class AuthorizePaymentBuilder: Builder<AuthorizePaymentDependency>, AuthorizePaymentBuildable {

    override init(dependency: AuthorizePaymentDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AuthorizePaymentListener) -> ViewableRouting {
        let component = AuthorizePaymentComponent(dependency: dependency)
        let viewController = AuthorizePaymentViewController()
        let interactor = AuthorizePaymentInteractor(presenter: viewController)
        interactor.listener = listener
        return AuthorizePaymentRouter(interactor: interactor, viewController: viewController)
    }
}
