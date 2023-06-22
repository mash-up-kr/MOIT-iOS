//
//  FineListBuilder.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import FineUserInterface

protocol FineListDependency: Dependency { }

final class FineListComponent: Component<FineListDependency> { }

// MARK: - Builder

final class FineListBuilder: Builder<FineListDependency>, FineListBuildable {

    override init(dependency: FineListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FineListListener) -> ViewableRouting {
        let component = FineListComponent(dependency: dependency)
        let viewController = FineListViewController()
        let interactor = FineListInteractor(presenter: viewController)
        interactor.listener = listener
        return FineListRouter(interactor: interactor, viewController: viewController)
    }
}
