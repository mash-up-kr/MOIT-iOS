//
//  MOITDetailAttendanceBuilder.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITDetailData
import MOITDetailDomainImpl

enum AttendanceTabType: CaseIterable {
    case allAttendance
    case myAttendance
    
    var title: String {
        switch self {
        case .allAttendance: return "전체출결"
        case .myAttendance: return "내 출결"
        }
    }
}
protocol MOITDetailAttendanceDependency: Dependency {
    var moitDetailRepository: MOITDetailRepository { get }
    
}

final class MOITDetailAttendanceComponent: Component<MOITDetailAttendanceDependency> {
}

// MARK: - Builder

protocol MOITDetailAttendanceBuildable: Buildable {
    func build(
        withListener listener: MOITDetailAttendanceListener,
               moitID: String
    ) -> MOITDetailAttendanceRouting
}

final class MOITDetailAttendanceBuilder: Builder<MOITDetailAttendanceDependency>,
                                         MOITDetailAttendanceBuildable {

    override init(dependency: MOITDetailAttendanceDependency) {
        super.init(dependency: dependency)
    }

    func build(
        withListener listener: MOITDetailAttendanceListener,
        moitID: String
    ) -> MOITDetailAttendanceRouting {
        let component = MOITDetailAttendanceComponent(dependency: dependency)
        let viewController = MOITDetailAttendanceViewController()
        let usecase = MOITAllAttendanceUsecaseImpl(repository: self.dependency.moitDetailRepository)
        let interactor = MOITDetailAttendanceInteractor(
            presenter: viewController,
            moitID: moitID,
            moitAllAttendanceUsecase: usecase,
            attendanceTabs: AttendanceTabType.allCases
        )
        interactor.listener = listener
        
        return MOITDetailAttendanceRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
