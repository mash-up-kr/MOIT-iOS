//
//  MOITDetailAttendanceInteractor.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift

protocol MOITDetailAttendanceRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MOITDetailAttendancePresentable: Presentable {
    var listener: MOITDetailAttendancePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MOITDetailAttendanceListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MOITDetailAttendanceInteractor: PresentableInteractor<MOITDetailAttendancePresentable>, MOITDetailAttendanceInteractable, MOITDetailAttendancePresentableListener {

    weak var router: MOITDetailAttendanceRouting?
    weak var listener: MOITDetailAttendanceListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MOITDetailAttendancePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        print(#function)
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
