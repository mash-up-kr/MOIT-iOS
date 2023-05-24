//
//  MOITWebBuilder.swift
//  MOITWebImpl
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import RIBs
import MOITWeb

final class MOITWebComponent: Component<MOITWebDependency> {
}

// MARK: - Builder

public final class MOITWebBuilder: Builder<MOITWebDependency>,
                                   MOITWebBuildable {

    public override init(dependency: MOITWebDependency) {
        super.init(dependency: dependency)
    }

    public func build(
        withListener listener: MOITWebListener,
        path: MOITWebPath
    ) -> ViewableRouting {
        let component = MOITWebComponent(dependency: dependency)
        let viewController = MOITWebViewController()
        let interactor = MOITWebInteractor(
            presenter: viewController,
            path: path.rawValue
        )
        interactor.listener = listener
        return MOITWebRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
