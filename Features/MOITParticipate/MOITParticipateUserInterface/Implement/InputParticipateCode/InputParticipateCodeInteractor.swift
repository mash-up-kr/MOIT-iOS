//
//  InputParticipateCodeInteractor.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITParticipateUserInterface
import MOITParticipateDomain

import RIBs
import RxSwift

protocol InputParticipateCodeRouting: ViewableRouting {
	func attachPariticipationSuccess()
	func detachPariticipationSuccess()
}

protocol InputParticipateCodePresentable: Presentable {
    var listener: InputParticipateCodePresentableListener? { get set }
}

protocol InputParticipateCodeInteractorDependency {
	var participateUseCase: ParticipateUseCase { get }
}

final class InputParticipateCodeInteractor: PresentableInteractor<InputParticipateCodePresentable>, InputParticipateCodeInteractable, InputParticipateCodePresentableListener {

    weak var router: InputParticipateCodeRouting?
    weak var listener: InputParticipateCodeListener?
	
	private let dependency: InputParticipateCodeInteractorDependency
	
	private let disposeBag: DisposeBag

    init(
		presenter: InputParticipateCodePresentable,
		dependency: InputParticipateCodeInteractorDependency
	) {
		self.dependency = dependency
		self.disposeBag = DisposeBag()
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
//		router?.attachPariticipationSuccess()
		dependency.participateUseCase.execute(with: code)
			.subscribe { event in
				switch event {
				case.success(let response):
					// TODO: moitId로 모잇 정보 조회하는 API 호출해야함
					break
				case .failure(let error):
					// TODO: toast 띄워야함 ~
					// TODO: toast로 띄워줄 에러 메세지를 받아와야함...흠
					break
				}
			}
			.disposed(by: disposeBag)
	}
	
	func participationSuccessDismissButtonDidTap() {
		router?.detachPariticipationSuccess()
	}
}
