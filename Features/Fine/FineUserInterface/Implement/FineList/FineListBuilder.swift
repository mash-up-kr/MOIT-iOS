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
import MOITDetailDomain

final class FineListComponent: Component<FineListDependency>,
							   AuthorizePaymentDependency,
							   FineListInteractorDependency {
	var convertAttendanceStatusUseCase: ConvertAttendanceStatusUseCase { dependency.convertAttendanceStatusUseCase }
	var filterMyFineListUseCase: FilterMyFineListUseCase { dependency.filterMyFineListUseCase }
	var fetchFineInfoUsecase: FetchFineInfoUseCase { dependency.fetchFineInfoUseCase }
	var compareUserIDUseCase: CompareUserIDUseCase { dependency.compareUserIDUseCase }
	var fetchFineItemUseCase: FetchFineItemUseCase {
		dependency.fetchFineItemUseCase }
	let moitID: Int
	
	init(
		dependency: FineListDependency,
		moitID: Int
	) {
		self.moitID = moitID
		super.init(dependency: dependency)
	}
}

// MARK: - Builder

public final class FineListBuilder: Builder<FineListDependency>, FineListBuildable {

    override public init(dependency: FineListDependency) {
        super.init(dependency: dependency)
    }

	public func build(
		withListener listener: FineListListener,
		moitID: Int
	) -> ViewableRouting {
        let component = FineListComponent(
			dependency: dependency,
			moitID: moitID
		)
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
