//
//  LoggedOutBuilder.swift
//  SignInUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthUserInterface
import AuthDomain

import RIBs

final class LoggedOutComponent: Component<LoggedOutDependency>,
								LoggedOutInteractorDependency {
	var saveTokenUseCase: SaveTokenUseCase { dependency.saveTokenUseCase }
}

// MARK: - Builder

public final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override public init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

	public func build(withListener listener: LoggedOutListener) -> ViewableRouting {
        let component = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(
							presenter: viewController,
							dependency: component
						)
        interactor.listener = listener
		
        return LoggedOutRouter(
			interactor: interactor,
			viewController: viewController,
			signInWebBuildable: dependency.moitWebBuildable,
			signUpBuildable: dependency.signUpBuildable
		)
    }
}
