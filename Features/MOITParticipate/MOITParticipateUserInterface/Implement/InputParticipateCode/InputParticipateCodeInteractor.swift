//
//  InputParticipateCodeInteractor.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//


import MOITParticipateUserInterface
import MOITParticipateDomain

import RIBs
import RxSwift

protocol InputParticipateCodeRouting: ViewableRouting { }

protocol InputParticipateCodePresentable: Presentable {
    var listener: InputParticipateCodePresentableListener? { get set }
}

final class InputParticipateCodeInteractor: PresentableInteractor<InputParticipateCodePresentable>, InputParticipateCodeInteractable, InputParticipateCodePresentableListener {

    weak var router: InputParticipateCodeRouting?
    weak var listener: InputParticipateCodeListener?
	
	private let dependency: InputParticipateCodeDependency

    init(
		presenter: InputParticipateCodePresentable,
		dependency: InputParticipateCodeDependency
	) {
		self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
	
	func completeButtonDidTap(with code: String) {
		debugPrint(code)
//		dependency.participateUseCase.execute(
//			with: .init(userId: 0, invitationCode: code)
//		)
	}
}
