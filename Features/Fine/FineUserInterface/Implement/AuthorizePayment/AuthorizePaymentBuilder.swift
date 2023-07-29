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

final class AuthorizePaymentComponent: Component<AuthorizePaymentDependency>, AuthorizePaymentInteractorDependency {
	let fineID: Int
	let moitID: Int
	
	init(
		dependency: AuthorizePaymentDependency,
		fineID: Int,
		moitID: Int
	) {
		self.fineID = fineID
		self.moitID = moitID
		super.init(dependency: dependency)
	}
}

// MARK: - Builder

final class AuthorizePaymentBuilder: Builder<AuthorizePaymentDependency>, AuthorizePaymentBuildable {

    override init(dependency: AuthorizePaymentDependency) {
        super.init(dependency: dependency)
    }

    func build(
		withListener listener: AuthorizePaymentListener,
		moitID: Int,
		fineID: Int
	) -> ViewableRouting {
        let component = AuthorizePaymentComponent(
			dependency: dependency,
			fineID: fineID,
			moitID: moitID
		)
        let viewController = AuthorizePaymentViewController()
        let interactor = AuthorizePaymentInteractor(
			presenter: viewController,
			dependency: component
		)
        interactor.listener = listener
        return AuthorizePaymentRouter(interactor: interactor, viewController: viewController)
    }
}
