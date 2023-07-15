//
//  MOITListBuilder.swift
//  MOITListUserInterfaceImpl
//
//  Created by kimchansoo on 2023/06/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

protocol MOITListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MOITListComponent: Component<MOITListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MOITListBuildable: Buildable {
    func build(withListener listener: MOITListListener) -> MOITListRouting
}

final class MOITListBuilder: Builder<MOITListDependency>, MOITListBuildable {

    override init(dependency: MOITListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MOITListListener) -> MOITListRouting {
        let component = MOITListComponent(dependency: dependency)
        let viewController = MOITListViewController()
        let interactor = MOITListInteractor(presenter: viewController)
        interactor.listener = listener
        return MOITListRouter(interactor: interactor, viewController: viewController)
    }
}
