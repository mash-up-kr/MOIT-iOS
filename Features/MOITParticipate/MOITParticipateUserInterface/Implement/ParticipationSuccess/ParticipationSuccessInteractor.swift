//
//  ParticipationSuccessInteractor.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITParticipateUserInterface
import MOITDetail

import RIBs
import RxSwift

protocol ParticipationSuccessRouting: ViewableRouting { }

protocol ParticipationSuccessPresentable: Presentable {
    var listener: ParticipationSuccessPresentableListener? { get set }
	
	func configure(_ viewModel: MOITDetailProfileInfoViewModel)
}

protocol ParticipationSuccessInteractorDependency {
	var viewModel: MOITDetailProfileInfoViewModel { get }
}

final class ParticipationSuccessInteractor: PresentableInteractor<ParticipationSuccessPresentable>, ParticipationSuccessInteractable, ParticipationSuccessPresentableListener {

    weak var router: ParticipationSuccessRouting?
    weak var listener: ParticipationSuccessListener?
	
	private let dependency: ParticipationSuccessInteractorDependency

    init(
		presenter: ParticipationSuccessPresentable,
		dependency: ParticipationSuccessInteractorDependency
	) {
		self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
	
	deinit { debugPrint("\(self) deinit") }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
	
	func showStudyDetailButtonDidTap() {
		// TODO: 스터디 상세로 이동해야함
	}
	
	func dismissButtonDidTap() {
		listener?.participationSuccessDismissButtonDidTap()
	}
	
	func viewDidLoad() {
		presenter.configure(dependency.viewModel)
	}
}
