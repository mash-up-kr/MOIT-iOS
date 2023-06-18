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
}

protocol MOITDetailAttendancePresentable: Presentable {
    var listener: MOITDetailAttendancePresentableListener? { get set }
}

protocol MOITDetailAttendanceListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MOITDetailAttendanceInteractor: PresentableInteractor<MOITDetailAttendancePresentable>,
                                            MOITDetailAttendanceInteractable,
                                            MOITDetailAttendancePresentableListener {

    weak var router: MOITDetailAttendanceRouting?
    weak var listener: MOITDetailAttendanceListener?

    override init(presenter: MOITDetailAttendancePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        print(#function)
    }

    override func willResignActive() {
        super.willResignActive()
    }
}
