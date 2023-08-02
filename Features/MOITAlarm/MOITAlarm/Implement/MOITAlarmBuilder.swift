//
//  MOITAlarmBuilder.swift
//  MOITAlarmImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITAlarm

final class MOITAlarmComponent: Component<MOITAlarmDependency> {
}

// MARK: - Builder

public final class MOITAlarmBuilder: Builder<MOITAlarmDependency>, MOITAlarmBuildable {

    public override init(dependency: MOITAlarmDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: MOITAlarmListener) -> ViewableRouting {
        let component = MOITAlarmComponent(dependency: dependency)
        let viewController = MOITAlarmViewController()
        let interactor = MOITAlarmInteractor(presenter: viewController)
        interactor.listener = listener
        return MOITAlarmRouter(interactor: interactor, viewController: viewController)
    }
}
