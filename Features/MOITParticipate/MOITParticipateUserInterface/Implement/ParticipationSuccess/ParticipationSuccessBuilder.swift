//
//  ParticipationSuccessBuilder.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import MOITParticipateUserInterface

protocol ParticipationSuccessDependency: Dependency { }

final class ParticipationSuccessComponent: Component<ParticipationSuccessDependency> { }

// MARK: - Builder

final class ParticipationSuccessBuilder: Builder<ParticipationSuccessDependency>, ParticipationSuccessBuildable {

    override init(dependency: ParticipationSuccessDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ParticipationSuccessListener) -> ViewableRouting {
        let component = ParticipationSuccessComponent(dependency: dependency)
        let viewController = ParticipationSuccessViewController()
        let interactor = ParticipationSuccessInteractor(presenter: viewController)
        interactor.listener = listener
        return ParticipationSuccessRouter(interactor: interactor, viewController: viewController)
    }
}
