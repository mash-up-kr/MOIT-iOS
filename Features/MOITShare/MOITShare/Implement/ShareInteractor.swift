//
//  ShareInteractor.swift
//  ShareImpl
//
//  Created by 송서영 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import MOITShare

protocol ShareRouting: ViewableRouting {
}

protocol SharePresentable: Presentable {
    var listener: SharePresentableListener? { get set }
}



final class ShareInteractor: PresentableInteractor<SharePresentable>, ShareInteractable, SharePresentableListener {

    weak var router: ShareRouting?
    weak var listener: ShareListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SharePresentable) {
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
