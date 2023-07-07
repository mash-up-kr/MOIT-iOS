//
//  MOITDetailAttendanceInteractor.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import MOITDetailDomain

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

    private let moitID: String
    private let moitAllAttendanceUsecase: MOITAllAttendanceUsecase
    
    init(
        presenter: MOITDetailAttendancePresentable,
        moitID: String,
        moitAllAttendanceUsecase: MOITAllAttendanceUsecase
    ) {
        self.moitID = moitID
        self.moitAllAttendanceUsecase = moitAllAttendanceUsecase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        moitAllAttendanceUsecase.fetchAllAttendance(moitID: self.moitID)
            .subscribe (onSuccess: { attendances in
                print(attendances)
            }, onError: { error in
                print(error, "error를 잡았따.")
            })
            .disposeOnDeactivate(interactor: self)
    }

    override func willResignActive() {
        super.willResignActive()
    }
}
