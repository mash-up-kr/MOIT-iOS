//
//  RootBuilder.swift
//  App
//
//  Created by 송서영 on 2023/05/22.
//

import RIBs
import MOITWebImpl
import MOITWeb

final class RootComponent: EmptyDependency, MOITWebDependency{
    
}
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
        let component = RootComponent()
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        
        let webBuilder = MOITWebBuilder(dependency: component)
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            moitWebBuilder: webBuilder
        )
    }
}
