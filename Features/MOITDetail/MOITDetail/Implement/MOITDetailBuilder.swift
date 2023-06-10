//
//  MOITDetailBuilder.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITDetail

final class MOITDetailComponent: Component<MOITDetailDependency> {
}

extension MOITDetailComponent: MOITDetailAttendanceDependency {
    
}

// MARK: - Builder

public final class MOITDetailBuilder: Builder<MOITDetailDependency>,
                                      MOITDetailBuildable {

    public override init(dependency: MOITDetailDependency) {
        super.init(dependency: dependency)
    }

    public func build(
        withListener listener: MOITDetailListener
    ) -> ViewableRouting {
        
        let component = MOITDetailComponent(dependency: dependency)
        let viewController = MOITDetailViewController()
        let interactor = MOITDetailInteractor(
            tabTypes: [.attendance, .fine],
            presenter: viewController
        )
        interactor.listener = listener
        
        let attendanceBuiler = MOITDetailAttendanceBuilder(dependency: component)
        
        return MOITDetailRouter(
            interactor: interactor,
            viewController: viewController,
            attendanceBuiler: attendanceBuiler
        )
    }
}
