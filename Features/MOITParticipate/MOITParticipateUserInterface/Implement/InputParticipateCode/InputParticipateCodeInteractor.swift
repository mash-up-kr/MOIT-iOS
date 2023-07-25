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
import MOITDetail
import MOITDetailDomain

import RIBs
import RxSwift

protocol InputParticipateCodeRouting: ViewableRouting {
	func attachPariticipationSuccess(with viewModel: MOITDetailProfileInfoViewModel)
	func detachPariticipationSuccess()
}

protocol InputParticipateCodePresentable: Presentable {
    var listener: InputParticipateCodePresentableListener? { get set }
	
	func showErrorToast(with message: String)
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
		dependency.participateUseCase.execute(with: code)
			.observe(on: MainScheduler.instance)
			.subscribe { [weak self] event in
				guard let self else { return }
				
				switch event {
				case.success(let moitDetailEntity):
					let moitDetailProfileInfoViewModel = self.convertToMOITDetailProfileInfoViewModel(
						model: moitDetailEntity
					)
					self.router?.attachPariticipationSuccess(with: moitDetailProfileInfoViewModel)
				case .failure(let error):
					// TODO: 서버에서 받은 에러 메세지 전달해야함
					self.presenter.showErrorToast(with: "존재하지 않는 스터디이에요!")
				}
			}
			.disposed(by: disposeBag)
	}
	
	func participationSuccessDismissButtonDidTap() {
		router?.detachPariticipationSuccess()
	}

	private func convertToMOITDetailProfileInfoViewModel(
		model: MOITDetailEntity
	) -> MOITDetailProfileInfoViewModel {
		let profileViewModel = MOITProfileInfoViewModel(
			imageUrl: model.imageURL,
			moitName: model.moitName
		)
		
		var detailViewModels = [
			MOITDetailInfoViewModel(
				title: "일정",
				description: model.scheduleDescription
			),
			MOITDetailInfoViewModel(
				title: "규칙",
				description: model.ruleLongDescription
			),
			MOITDetailInfoViewModel(
				title: "기간",
				description: model.periodDescription
			)
		]
		
		if model.isNotificationActive {
			detailViewModels.insert(
				MOITDetailInfoViewModel(
					title: "알람",
					description: model.notificationDescription
				),
				at: 2
			)
		}
		
		return MOITDetailProfileInfoViewModel(
			profileInfo: profileViewModel,
			detailInfos: detailViewModels
		)
	}
}
