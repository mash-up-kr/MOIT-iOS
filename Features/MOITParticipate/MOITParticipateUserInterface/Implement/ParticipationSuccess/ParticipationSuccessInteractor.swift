//
//  ParticipationSuccessInteractor.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift

protocol ParticipationSuccessRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ParticipationSuccessPresentable: Presentable {
    var listener: ParticipationSuccessPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ParticipationSuccessListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ParticipationSuccessInteractor: PresentableInteractor<ParticipationSuccessPresentable>, ParticipationSuccessInteractable, ParticipationSuccessPresentableListener {

    weak var router: ParticipationSuccessRouting?
    weak var listener: ParticipationSuccessListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ParticipationSuccessPresentable) {
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
