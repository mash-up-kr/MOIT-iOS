//
//  MOITSettingInteractor.swift
//  MOITSettingImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import MOITSetting

protocol MOITSettingRouting: ViewableRouting {
}

protocol MOITSettingPresentable: Presentable {
    var listener: MOITSettingPresentableListener? { get set }
}

final class MOITSettingInteractor: PresentableInteractor<MOITSettingPresentable>, MOITSettingInteractable, MOITSettingPresentableListener {

    weak var router: MOITSettingRouting?
    weak var listener: MOITSettingListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MOITSettingPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
