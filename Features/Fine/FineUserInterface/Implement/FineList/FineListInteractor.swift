//
//  FineListInteractor.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift

import FineUserInterface
import FineDomain
import MOITDetailDomain
import DesignSystem

protocol FineListRouting: ViewableRouting {
	func attachAuthorizePayment()
	func detachAuthorizePayment()
}

protocol FineListPresentable: Presentable {
    var listener: FineListPresentableListener? { get set }
}

protocol FineListInteractorDependency {
	var fetchFineInfoUsecase: FetchFineInfoUseCase { get }
	var compareUserIDUseCase: CompareUserIDUseCase { get }
	var moitID: String { get }
}

final class FineListInteractor: PresentableInteractor<FineListPresentable>, FineListInteractable, FineListPresentableListener {

    weak var router: FineListRouting?
    weak var listener: FineListListener?
	
	private let dependency: FineListInteractorDependency

    init(
		presenter: FineListPresentable,
		dependency: FineListInteractorDependency
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
	
	func fineListDidTap(with fineItem: FineItem) {
		router?.attachAuthorizePayment()
	}
	
	func authorizePaymentDismissButtonDidTap() {
		router?.detachAuthorizePayment()
	}
	
// MARK: - FineListPresentableListener
	
	func viewDidLoad() {
		dependency.fetchFineInfoUsecase.execute(moitID: dependency.moitID)
		// TODO: 받아온 Entity.....어떻게 할건데?!
	}
	
// MARK: - private
	
	private func convertToParticipantNotPaidFineListViewModel(
		from entity: FineItemEntity
	) -> ParticipantNotPaidFineListViewModel {
		
		let isMyFine = dependency.compareUserIDUseCase.execute(with: entity.userID)
		// TODO: 이 부분 서버에서 어떻게 내려주는지 확인 필요
		let nickName = isMyFine ? "나" : entity.userNickname
		
		return ParticipantNotPaidFineListViewModel(
			fineID: entity.id,
			fineAmount: entity.fineAmount,
			chipType: convertAttendanceStatusToMOITChipType(status: entity.attendanceStatus),
			isMyFine: isMyFine,
			useNickName: nickName,
			studyOrder: entity.studyOrder,
			isApproved: entity.isApproved
		)
	}
	
	private func convertToPaymentCompletedFineListViewModel(
		from entity: FineItemEntity
	) -> PaymentCompletedFineListViewModel {
		
		// TODO: nickname 받는 부분까지 useCase에서 처리?
		let isMyFine = dependency.compareUserIDUseCase.execute(with: entity.userID)
		// TODO: 이 부분 서버에서 어떻게 내려주는지 확인 필요
		let nickName = isMyFine ? "나" : entity.userNickname
		
		return PaymentCompletedFineListViewModel(
			fineAmount: entity.fineAmount,
			chipType: convertAttendanceStatusToMOITChipType(status: entity.attendanceStatus),
			useNickName: nickName,
			// TODO: Date 변환 필요
			approvedDate: entity.approveAt
		)
	}
	
	

	private func convertAttendanceStatusToMOITChipType(
		status: AttendanceStatus
	) -> MOITChipType {
		switch status {
			case .LATE:
				return .late
			case .ABSENCE:
				return .absent
			default:
				return .absent
		}
	}
}
