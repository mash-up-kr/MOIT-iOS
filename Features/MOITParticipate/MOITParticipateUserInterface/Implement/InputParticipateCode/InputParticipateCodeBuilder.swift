//
//  InputParticipateCodeBuilder.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import MOITParticipateUserInterface
import MOITParticipateData
import MOITParticipateDomain

public protocol InputParticipateCodeDependency: Dependency {
	var participateUseCase: ParticipateUseCase { get }
}

final class InputParticipateCodeComponent: Component<InputParticipateCodeDependency>,
										   InputParticipateCodeDependency,
										   ParticipationSuccessDependency {
	var participateUseCase: ParticipateUseCase { dependency.participateUseCase }
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
