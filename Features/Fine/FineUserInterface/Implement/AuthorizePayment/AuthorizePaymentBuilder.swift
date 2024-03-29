//
//  AuthorizePaymentBuilder.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import FineUserInterface
import FineDomain
import MOITDetailDomain

import RIBs

final class AuthorizePaymentComponent: Component<AuthorizePaymentDependency>, AuthorizePaymentInteractorDependency {
	
	var convertAttendanceStatusUseCase: ConvertAttendanceStatusUseCase { dependency.convertAttendanceStatusUseCase }
	var compareUserIDUseCase: CompareUserIDUseCase { dependency.compareUserIDUseCase }
	var fetchFineItemUseCase: FetchFineItemUseCase { dependency.fetchFineItemUseCase }
	var postFineEvaluateUseCase: PostFineEvaluateUseCase {
		dependency.postFineEvaluateUseCase
	}
	var postMasterAuthorizeUseCase: PostMasterAuthorizeUseCase { dependency.postMasterAuthorizeUseCase }
	
	let fineID: Int
	let moitID: Int
	let isMaster: Bool
	
	init(
		dependency: AuthorizePaymentDependency,
		fineID: Int,
		moitID: Int,
		isMaster: Bool
	) {
		self.fineID = fineID
		self.moitID = moitID
		self.isMaster = isMaster
		super.init(dependency: dependency)
	}
}

// MARK: - Builder

public final class AuthorizePaymentBuilder: Builder<AuthorizePaymentDependency>, AuthorizePaymentBuildable {

    public override init(dependency: AuthorizePaymentDependency) {
        super.init(dependency: dependency)
    }

    public func build(
        withListener listener: AuthorizePaymentListener,
        moitID: Int,
        fineID: Int,
        isMaster: Bool
    ) -> (router: ViewableRouting, actionableItem: AuthorizePaymentActionableItem) {
        let component = AuthorizePaymentComponent(
			dependency: dependency,
			fineID: fineID,
			moitID: moitID,
			isMaster: isMaster
		)
        let viewController = AuthorizePaymentViewController()
        let interactor = AuthorizePaymentInteractor(
			presenter: viewController,
			dependency: component
		)
        interactor.listener = listener
        let router = AuthorizePaymentRouter(
            interactor: interactor,
            viewController: viewController
        )
        return (router, interactor)
    }
}
