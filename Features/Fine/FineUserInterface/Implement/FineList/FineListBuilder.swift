//
//  FineListBuilder.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import FineUserInterface
import FineDomain

final class FineListComponent: Component<FineListDependency>,
							   AuthorizePaymentDependency,
							   FineListInteractorDependency {
    var fetchFineInfoUsecase: FetchFineInfoUseCase { dependency.fetchFineInfoUseCase }
}

// MARK: - Builder

public final class FineListBuilder: Builder<FineListDependency>, FineListBuildable {

    override public init(dependency: FineListDependency) {
        super.init(dependency: dependency)
    }

	public func build(
		withListener listener: FineListListener,
		moitID: String
	) -> ViewableRouting {
        let component = FineListComponent(dependency: dependency)
        let viewController = FineListViewController()
        let interactor = FineListInteractor(
			presenter: viewController,
			dependency: component
		)
        interactor.listener = listener
		
		let authorizePaymentBuildable = AuthorizePaymentBuilder(dependency: component)
		return FineListRouter(
			authorizePaymentBuildable: authorizePaymentBuildable,
			interactor: interactor,
			viewController: viewController
		)
    }
}
