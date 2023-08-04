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
}

protocol InputParticipateCodePresentable: Presentable {
    var listener: InputParticipateCodePresentableListener? { get set }
	
	func showErrorToast()
}

protocol InputParticipateCodeInteractorDependency {
	var participateUseCase: ParticipateUseCase { get }
	var moitDetailUseCase: MOITDetailUsecase { get }
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
	
	deinit { debugPrint("\(self) deinit") }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    func didTapBackButton() {
        self.listener?.inputParticiateCodeDidTapBack()
    }
	func completeButtonDidTap(with code: String) {
		dependency.participateUseCase.execute(with: code)
			.observe(on: MainScheduler.instance)
			.subscribe { [weak self] event in
				guard let self else { return }
				
				switch event {
				case.success(let participateEntity):
					let moitDetailProfileInfoViewModel = self.convertToMOITDetailProfileInfoViewModel(
						model: participateEntity
					)
					self.router?.attachPariticipationSuccess(with: moitDetailProfileInfoViewModel)
				case .failure:
					self.presenter.showErrorToast()
				}
			}
			.disposed(by: disposeBag)
	}
	
	func participationSuccessDismissButtonDidTap() {
		listener?.moveToMOITListButtonDidTap()
	}

	private func convertToMOITDetailProfileInfoViewModel(
		model: ParticipateEntity
	) -> MOITDetailProfileInfoViewModel {
		let profileViewModel = MOITProfileInfoViewModel(
			imageUrl: model.imageURL,
			moitName: model.moitName
		)
		
		let scheduleDescription = dependency.moitDetailUseCase.moitScheduleDescription(
			scheduleDayOfWeeks: model.scheduleDayOfWeeks,
			scheduleRepeatCycle: model.scheduleRepeatCycle,
			scheduleStartTime: model.scheduleStartTime,
			scheduleEndTime: model.scheduleEndTime
		)
		let ruleLongDescription = dependency.moitDetailUseCase.ruleLongDescription(
			fineLateTime: model.fineLateTime,
			fineLateAmount: model.fineLateAmount,
			fineAbsenceTime: model.fineAbsenceTime,
			fineAbsenceAmount: model.fineAbsenceAmount
		)
		let notificationDescription = dependency.moitDetailUseCase.notificationDescription(
			remindOption: model.notificationRemindOption
		)
		let periodDescription = dependency.moitDetailUseCase.periodDescription(
			startDate: model.startDate,
			endDate: model.endDate
		)
		
		var detailViewModels = [
			MOITDetailInfoViewModel(
				title: "일정",
				description: scheduleDescription
			),
			MOITDetailInfoViewModel(
				title: "규칙",
				description: ruleLongDescription
			),
			MOITDetailInfoViewModel(
				title: "기간",
				description: periodDescription
			)
		]
		
		if model.isRemindActive {
			detailViewModels.insert(
				MOITDetailInfoViewModel(
					title: "알람",
					description: notificationDescription
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
