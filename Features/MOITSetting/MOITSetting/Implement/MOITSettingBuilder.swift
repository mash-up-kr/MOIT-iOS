//
//  MOITSettingBuilder.swift
//  MOITSettingImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITSetting
import MOITWeb
import MOITWebImpl

final class MOITSettingComponent: Component<MOITSettingDependency>,
                                  MOITWebDependency {
}

// MARK: - Builder

public final class MOITSettingBuilder: Builder<MOITSettingDependency>, MOITSettingBuildable {

    public override init(dependency: MOITSettingDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: MOITSettingListener) -> ViewableRouting {
        let component = MOITSettingComponent(dependency: dependency)
        let viewController = MOITSettingViewController()
        let interactor = MOITSettingInteractor(presenter: viewController)
        interactor.listener = listener
        
        let moitWebBuilder = MOITWebBuilder(dependency: component)
        
        return MOITSettingRouter(
            interactor: interactor,
            viewController: viewController,
            moitWebBuilder: moitWebBuilder
        )
    }
}
