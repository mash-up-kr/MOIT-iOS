//
//  RootBuilder.swift
//  App
//
//  Created by 송서영 on 2023/05/22.
//

import RIBs

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<EmptyDependency>, RootBuildable {

    override init(dependency: EmptyDependency) {
        super.init(dependency: dependency)
    }
    
    deinit { debugPrint("\(self) deinit") }

    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        
        return RootRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
