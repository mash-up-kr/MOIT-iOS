//
//  MOITDetailAttendanceBuilder.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

protocol MOITDetailAttendanceDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MOITDetailAttendanceComponent: Component<MOITDetailAttendanceDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MOITDetailAttendanceBuildable: Buildable {
    func build(withListener listener: MOITDetailAttendanceListener) -> MOITDetailAttendanceRouting
}

final class MOITDetailAttendanceBuilder: Builder<MOITDetailAttendanceDependency>, MOITDetailAttendanceBuildable {

    override init(dependency: MOITDetailAttendanceDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MOITDetailAttendanceListener) -> MOITDetailAttendanceRouting {
        let component = MOITDetailAttendanceComponent(dependency: dependency)
        let viewController = MOITDetailAttendanceViewController()
        let interactor = MOITDetailAttendanceInteractor(presenter: viewController)
        interactor.listener = listener
        return MOITDetailAttendanceRouter(interactor: interactor, viewController: viewController)
    }
}
