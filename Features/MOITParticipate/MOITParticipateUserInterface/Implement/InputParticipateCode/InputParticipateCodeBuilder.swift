//
//  InputParticipateCodeBuilder.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import MOITParticipateUserInterface
import MOITParticipateDataImpl
import MOITParticipateData
import MOITParticipateDomainImpl
import MOITParticipateDomain



final class InputParticipateCodeComponent: Component<InputParticipateCodeDependency>,
										   InputParticipateCodeInteractorDependency,
										   ParticipationSuccessDependency {
	var participateUseCase: ParticipateUseCase { ParticipateUseCaseImpl(participateRepository: participateRepository) }
	let participateRepository: ParticipateRepository
	
	override init(
		dependency: InputParticipateCodeDependency
	) {
		self.participateRepository = ParticipateRepositoryImpl(network: dependency.network)
		super.init(dependency: dependency)
	}
}

// MARK: - Builder

public final class InputParticipateCodeBuilder: Builder<InputParticipateCodeDependency>, InputParticipateCodeBuildable {

    override public init(dependency: InputParticipateCodeDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: InputParticipateCodeListener) -> ViewableRouting {
        let component = InputParticipateCodeComponent(dependency: dependency)
        let viewController = InputParticipateCodeViewController()
        let interactor = InputParticipateCodeInteractor(
          presenter: viewController,
          dependency: component
        )
        interactor.listener = listener

        let participationSuccessBuildable = ParticipationSuccessBuilder(dependency: component)

        return InputParticipateCodeRouter(
          interactor: interactor,
          viewController: viewController,
          participationSuccessBuildable: participationSuccessBuildable
        )
    }
}
