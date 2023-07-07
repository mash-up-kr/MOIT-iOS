//
//  LoggedOutBuilder.swift
//  SignInUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import SignInUserInterface

import RIBs

public protocol LoggedOutDependency: Dependency {
}

final class LoggedOutComponent: Component<LoggedOutDependency> {
}

// MARK: - Builder

public final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override public init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

	public func build(withListener listener: LoggedOutListener) -> ViewableRouting {
        let component = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(presenter: viewController)
        interactor.listener = listener
        return LoggedOutRouter(interactor: interactor, viewController: viewController)
    }
}
