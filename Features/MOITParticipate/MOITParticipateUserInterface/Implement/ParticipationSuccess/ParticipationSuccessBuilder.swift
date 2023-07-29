//
//  ParticipationSuccessBuilder.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import MOITParticipateUserInterface
import MOITDetail

protocol ParticipationSuccessDependency: Dependency { }

final class ParticipationSuccessComponent: Component<ParticipationSuccessDependency>,
										   ParticipationSuccessInteractorDependency {
	let viewModel: MOITDetailProfileInfoViewModel
	
	init(
		dependency: ParticipationSuccessDependency,
		viewModel: MOITDetailProfileInfoViewModel
	) {
		self.viewModel = viewModel
		super.init(dependency: dependency)
	}
}

// MARK: - Builder

final class ParticipationSuccessBuilder: Builder<ParticipationSuccessDependency>, ParticipationSuccessBuildable {

    override init(dependency: ParticipationSuccessDependency) {
        super.init(dependency: dependency)
    }

    func build(
		withListener listener: ParticipationSuccessListener,
		withViewModel viewModel: MOITDetailProfileInfoViewModel
	) -> ViewableRouting {
        let component = ParticipationSuccessComponent(
			dependency: dependency,
			viewModel: viewModel
		)
        let viewController = ParticipationSuccessViewController()
        let interactor = ParticipationSuccessInteractor(
			presenter: viewController,
			dependency: component
		)
        interactor.listener = listener
        return ParticipationSuccessRouter(interactor: interactor, viewController: viewController)
    }
}
