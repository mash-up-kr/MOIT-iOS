//
//  LoggedOutBuilder.swift
//  SignInUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import SignInUserInterface
import MOITWeb
import MOITWebImpl

import RIBs

public protocol LoggedOutDependency: Dependency { }

final class LoggedOutComponent: Component<LoggedOutDependency>, MOITWebDependency { }

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
		
		// TODO: 추후 수정
		let signInWebBuildable = MOITWebBuilder(dependency: component)
		
        return LoggedOutRouter(
			interactor: interactor,
			viewController: viewController,
			signInWebBuildable: signInWebBuildable
		)
    }
}
