//
//  ParticipationSuccessInteractor.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift

import MOITParticipateUserInterface

protocol ParticipationSuccessRouting: ViewableRouting { }

protocol ParticipationSuccessPresentable: Presentable {
    var listener: ParticipationSuccessPresentableListener? { get set }
}

final class ParticipationSuccessInteractor: PresentableInteractor<ParticipationSuccessPresentable>, ParticipationSuccessInteractable, ParticipationSuccessPresentableListener {

    weak var router: ParticipationSuccessRouting?
    weak var listener: ParticipationSuccessListener?

    override init(presenter: ParticipationSuccessPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
	
	func dismissButtonDidTap() {
		listener?.participationSuccessDismissButtonDidTap()
	}
}
