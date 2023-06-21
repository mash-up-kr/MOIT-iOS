//
//  ProfileSelectInteractor.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/21.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//
import SignUpUserInterface

import RIBs
import RxSwift

protocol ProfileSelectRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ProfileSelectPresentable: Presentable {
    var listener: ProfileSelectPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

final class ProfileSelectInteractor: PresentableInteractor<ProfileSelectPresentable>, ProfileSelectInteractable, ProfileSelectPresentableListener {

    weak var router: ProfileSelectRouting?
    weak var listener: ProfileSelectListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ProfileSelectPresentable) {
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
