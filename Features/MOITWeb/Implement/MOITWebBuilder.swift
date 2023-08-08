//
//  MOITWebBuilder.swift
//  MOITWebImpl
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import RIBs
import MOITWeb

import MOITShare
import MOITShareImpl


final class MOITWebComponent: Component<MOITWebDependency>,
                              ShareDependency {
}

// MARK: - Builder

public final class MOITWebBuilder: Builder<MOITWebDependency>,
                                   MOITWebBuildable {

    public override init(dependency: MOITWebDependency) {
        super.init(dependency: dependency)
    }
    
    deinit { debugPrint("\(self) deinit") }

    public func build(
        withListener listener: MOITWebListener,
        domain: WebDomain,
        path: MOITWebPath
    ) -> (router: ViewableRouting, actionableItem: MOITWebActionableItem) {
        let component = MOITWebComponent(dependency: dependency)
        
        let viewController = MOITWebViewController()
        let interactor = MOITWebInteractor(
            presenter: viewController,
            domain: domain.rawValue,
            path: path.path
        )
        interactor.listener = listener
        
        let shareBuilder = ShareBuilder(dependency: component)
        let router = MOITWebRouter(
            interactor: interactor,
            viewController: viewController,
            shareBuilder: shareBuilder
        )
        return (router, interactor)
    }
}
