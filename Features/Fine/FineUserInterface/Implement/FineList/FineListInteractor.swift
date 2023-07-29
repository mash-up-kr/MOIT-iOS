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
	
	func configure(_ viewModel: FineInfoViewModel)
}

public protocol FineListInteractorDependency {
	var fetchFineInfoUsecase: FetchFineInfoUseCase { get }
	var compareUserIDUseCase: CompareUserIDUseCase { get }
	var filterMyFineListUseCase: FilterMyFineListUseCase { get }
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
	
//	func fineListDidTap(with fineItem: FineItem) {
//		router?.attachAuthorizePayment()
//	}
	
	func authorizePaymentDismissButtonDidTap() {
		router?.detachAuthorizePayment()
	}
	
// MARK: - FineListPresentableListener
	
	func viewDidLoad() {
		dependency.fetchFineInfoUsecase.execute(moitID: dependency.moitID)
			.compactMap { [weak self] fineInfoEntity -> FineInfoViewModel? in
				return self?.convertToFineInfoViewModel(from: fineInfoEntity, isMaster: true)
			}
			.subscribe(
				onSuccess: { [weak self] fineInfoViewModel in
					debugPrint("------------FineInfoViewModel-------------")
					debugPrint(fineInfoViewModel)
					debugPrint("------------------------------------------")
					self?.presenter.configure(fineInfoViewModel)
				}
			)
			.disposeOnDeactivate(interactor: self)
	}
	
// MARK: - private
	
	/// FineInfoEntity -> FineInfoViewModel
	private func convertToFineInfoViewModel(
		from entity: FineInfoEntity,
		isMaster: Bool
	) -> FineInfoViewModel {
		
		let filteredFineListEntity = dependency.filterMyFineListUseCase.execute(
			fineList: entity.notPaidFineList
		)
		
		return FineInfoViewModel(
			totalFineAmountText: "\(entity.totalFineAmount)",
			myNotPaidFineListViewModel: filteredFineListEntity.myFineList.map { convertToNotPaidFineListViewModel(from: $0, isMaster: isMaster) },
			othersNotPaidFineListViewModel: filteredFineListEntity.othersFineList.map { convertToNotPaidFineListViewModel(from: $0, isMaster: isMaster) },
			paymentCompletedFineListViewModel: entity.paymentCompletedFineList.map { convertToPaymentCompletedFineListViewModel(from: $0) }
		)
	}
	
	/// FineItemEnitty -> 벌금미납부내역
	private func convertToNotPaidFineListViewModel(
		from entity: FineItemEntity,
		isMaster: Bool
	) -> NotPaidFineListViewModel {
		
		let isMyFine = dependency.compareUserIDUseCase.execute(with: entity.userID)
		let nickName = isMyFine ? "나" : entity.userNickname
		
		return NotPaidFineListViewModel(
			fineID: entity.id,
			fineAmount: entity.fineAmount,
			chipType: convertAttendanceStatusToMOITChipType(status: entity.attendanceStatus),
			isMyFine: isMyFine,
			userNickName: nickName,
			studyOrder: entity.studyOrder,
			imageURL: entity.imageURL,
			buttonTitle: convertFineApproveStatusToButtonTitle(
				status: entity.fineApproveStatus,
				isMyFineItem: isMyFine,
				isMaster: isMaster
			)
		)
	}
	
	/// FineItemEntity -> 벌금납부내역
	private func convertToPaymentCompletedFineListViewModel(
		from entity: FineItemEntity
	) -> PaymentCompletedFineListViewModel {
		
		let isMyFine = dependency.compareUserIDUseCase.execute(with: entity.userID)
		let nickName = isMyFine ? "나" : entity.userNickname
		
		return PaymentCompletedFineListViewModel(
			fineAmount: entity.fineAmount,
			chipType: convertAttendanceStatusToMOITChipType(status: entity.attendanceStatus),
			useNickName: nickName,
			// TODO: Date 변환 필요
			approvedDate: entity.approveAt
		)
	}
	
	private func convertFineApproveStatusToButtonTitle(
		status: FineApproveStatus,
		isMyFineItem: Bool,
		isMaster: Bool
	) -> String? {
		
		if isMaster {
			switch status {
			case .new:
				return isMyFineItem ? "납부 인증하기" : nil
			case .inProgress, .rejected:
				return "인증 확인하기"
			default:
				return nil
			}
		} else {
			switch status {
			case .new:
				return isMyFineItem ? "납부 인증하기" : nil
			case .inProgress, .rejected:
				return isMyFineItem ? "인증 대기 중" : nil
			default:
				return nil
			}
		}
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
