//
//  MOITListBuilder.swift
//  MOITListUserInterfaceImpl
//
//  Created by kimchansoo on 2023/06/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITListUserInterface

import RIBs

final class MOITListComponent: Component<MOITListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public final class MOITListBuilder: Builder<MOITListDependency>, MOITListBuildable {

    public override init(dependency: MOITListDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: MOITListListener) -> ViewableRouting {
        let component = MOITListComponent(dependency: dependency)
        let viewController = MOITListViewController()
        let interactor = MOITListInteractor(presenter: viewController)
        interactor.listener = listener
        return MOITListRouter(interactor: interactor, viewController: viewController)
    }
}
