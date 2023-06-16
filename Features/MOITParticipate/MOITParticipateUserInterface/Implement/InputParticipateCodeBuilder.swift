//
//  InputParticipateCodeBuilder.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

protocol InputParticipateCodeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class InputParticipateCodeComponent: Component<InputParticipateCodeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol InputParticipateCodeBuildable: Buildable {
    func build(withListener listener: InputParticipateCodeListener) -> InputParticipateCodeRouting
}

final class InputParticipateCodeBuilder: Builder<InputParticipateCodeDependency>, InputParticipateCodeBuildable {

    override init(dependency: InputParticipateCodeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: InputParticipateCodeListener) -> InputParticipateCodeRouting {
        let component = InputParticipateCodeComponent(dependency: dependency)
        let viewController = InputParticipateCodeViewController()
        let interactor = InputParticipateCodeInteractor(presenter: viewController)
        interactor.listener = listener
        return InputParticipateCodeRouter(interactor: interactor, viewController: viewController)
    }
}
