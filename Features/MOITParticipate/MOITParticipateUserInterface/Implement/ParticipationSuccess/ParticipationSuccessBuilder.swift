//
//  ParticipationSuccessBuilder.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

protocol ParticipationSuccessDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ParticipationSuccessComponent: Component<ParticipationSuccessDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ParticipationSuccessBuildable: Buildable {
    func build(withListener listener: ParticipationSuccessListener) -> ParticipationSuccessRouting
}

final class ParticipationSuccessBuilder: Builder<ParticipationSuccessDependency>, ParticipationSuccessBuildable {

    override init(dependency: ParticipationSuccessDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ParticipationSuccessListener) -> ParticipationSuccessRouting {
        let component = ParticipationSuccessComponent(dependency: dependency)
        let viewController = ParticipationSuccessViewController()
        let interactor = ParticipationSuccessInteractor(presenter: viewController)
        interactor.listener = listener
        return ParticipationSuccessRouter(interactor: interactor, viewController: viewController)
    }
}
