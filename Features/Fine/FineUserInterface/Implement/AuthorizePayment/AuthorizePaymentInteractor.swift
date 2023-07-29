//
//  AuthorizePaymentInteractor.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import FineUserInterface
import FineDomain
import MOITDetailDomain
import DesignSystem

import RIBs
import RxSwift
import Kingfisher

protocol AuthorizePaymentRouting: ViewableRouting { }

protocol AuthorizePaymentPresentable: Presentable {
    var listener: AuthorizePaymentPresentableListener? { get set }
	
	func configure(_ viewModel: AuthorizePaymentViewModel)
}

protocol AuthorizePaymentInteractorDependency {
	var fineID: Int { get }
	var moitID: Int { get }
	var isMaster: Bool { get }
	var fetchFineItemUseCase: FetchFineItemUseCase { get }
	var convertAttendanceStatusUseCase: ConvertAttendanceStatusUseCase { get }
	var compareUserIDUseCase: CompareUserIDUseCase { get }
}

final class AuthorizePaymentInteractor: PresentableInteractor<AuthorizePaymentPresentable>, AuthorizePaymentInteractable, AuthorizePaymentPresentableListener {

    weak var router: AuthorizePaymentRouting?
    weak var listener: AuthorizePaymentListener?
	
	private let dependency: AuthorizePaymentInteractorDependency

    init(
		presenter: AuthorizePaymentPresentable,
		dependency: AuthorizePaymentInteractorDependency
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
	
	deinit { debugPrint("\(self) deinit") }
	
// MARK: - private
	
	private func fetchData() {
		dependency.fetchFineItemUseCase.execute(
			moitID: dependency.moitID,
			fineID: dependency.fineID
		)
		.compactMap { [weak self] entity -> AuthorizePaymentViewModel? in
			return self?.convertFineItemEntityToViewModel(entity: entity)
		}
		.subscribe(
			onSuccess: { [weak self] viewModel in
				self?.presenter.configure(viewModel)
			},
			onDisposed: {
				debugPrint("this subscription has terminated!!!!")
			}
		)
		.disposeOnDeactivate(interactor: self)
	}
	
	private func convertFineItemEntityToViewModel(
		entity: FineItemEntity
	) -> AuthorizePaymentViewModel {
		
		let isMyFine = dependency.compareUserIDUseCase.execute(with: entity.userID)
		let buttonTitle = (isMyFine && entity.fineApproveStatus == .inProgress) ? "사진 재등록하기" : nil
		
		return AuthorizePaymentViewModel(
			isMaster: dependency.isMaster,
			imageURL: entity.imageURL,
			imageFile: nil,
			fineID: entity.id,
			fineAmount: "\(entity.fineAmount)원", // TODO: numberFormatter 필요
			chipType: dependency.convertAttendanceStatusUseCase.execute(attendanceStatus: entity.attendanceStatus),
			userNickName: entity.userNickname,
			studyOrder: entity.studyOrder,
			buttonTitle: buttonTitle,
			approveStatus: entity.fineApproveStatus
		)
	}
	
// MARK: - AuthorizePaymentPresentableListener
	
	func dismissButtonDidTap() {
		listener?.authorizePaymentDismissButtonDidTap()
	}
	
	func viewDidLoad() {
		fetchData()
	}
}
