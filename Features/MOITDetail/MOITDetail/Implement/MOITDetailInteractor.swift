//
//  MOITDetailInteractor.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITDetail
import MOITDetailDomain
import DesignSystem

import RIBs
import RxSwift
import RxRelay
import FineUserInterface
import FineDomain

protocol MOITDetailRouting: ViewableRouting {
    func attachAttendance(moitID: String)
    func attachMOITUsers(moitID: String)
    func detachMOITUsers(withPop: Bool)
    func attachMOITShare(code: String)
    func detachMOITShare()
	func attachFineList(moitID: Int)
	func attachAuthorizePayment(moitID: Int, fineID: Int, isMaster: Bool)
	func detachAuthorizePayment(completion: (() -> Void)?, withPop: Bool)
    @discardableResult
    func attachFineList(moitID: Int) -> FineActionableItem?
}

protocol MOITDetailPresentable: Presentable {
    var listener: MOITDetailPresentableListener? { get set }
    func configure(_ viewModel: MOITDetailViewModel)
    func update(infoViewModel: MOITDetailInfosViewModel)
    func showAlert(message: String)
    func shouldLayout()
	func showToast(message: String, type: MOITToastType)
}

final class MOITDetailInteractor: PresentableInteractor<MOITDetailPresentable>,
                                  MOITDetailInteractable,
								  MOITDetailPresentableListener {
    
    func didTapInfoButton(type: MOITDetailInfoViewButtonType) {
        switch type {
        case .canEdit:
            print("수정페이지로 이동해야됨 !")
        case .fold:
            guard let scheduleDescription,
                  let longRuleDescription,
                  let periodDescription else { return }
            let infosViewModel = self.moitInfosViewModel(
                buttonType: .unfold,
                scheduleDescription: scheduleDescription,
                ruleDescription: longRuleDescription,
                periodDescription: periodDescription
            )
            self.presenter.update(infoViewModel: infosViewModel)
        case .unfold:
            guard let scheduleDescription,
                  let shortRuleDescription,
                  let periodDescription else { return }
            let infosViewModel = self.moitInfosViewModel(
                buttonType: .fold,
                scheduleDescription: scheduleDescription,
                ruleDescription: shortRuleDescription,
                periodDescription: periodDescription
            )
            self.presenter.update(infoViewModel: infosViewModel)
        }
    }

    weak var router: MOITDetailRouting?
    weak var listener: MOITDetailListener?
    
    private let tabTypes: [MOITDetailTab]
    private let detailUsecase: MOITDetailUsecase
    private let isMasterUsecase: CompareUserIDUseCase
    private let moitID: String
    private let isMasterRelay: PublishRelay<Bool>
    
    private var scheduleDescription: String?
    private var longRuleDescription: String?
    private var shortRuleDescription: String?
    private var periodDescription: String?
    
    private var invitationCode: String?
    
    init(
        moitID: String,
        tabTypes: [MOITDetailTab],
        presenter: MOITDetailPresentable,
        detailUsecase: MOITDetailUsecase,
        isMasterUsecase: CompareUserIDUseCase,
        isMasterRelay: PublishRelay<Bool>
    ) {
        self.isMasterRelay = isMasterRelay
        self.moitID = moitID
        self.detailUsecase = detailUsecase
        self.tabTypes = tabTypes
        self.isMasterUsecase = isMasterUsecase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    private func fetchMOITDetail(with id: String) {
        self.detailUsecase.moitDetail(with: id)
            .do(onSuccess: { [weak self] in
                guard let self else { return }
                self.scheduleDescription = $0.scheduleDescription
                self.longRuleDescription = $0.ruleLongDescription
                self.shortRuleDescription = $0.ruleShortDescription
                self.periodDescription = $0.periodDescription
                self.invitationCode = $0.invitationCode
                let isMaster = self.isMasterUsecase.execute(with: Int($0.masterID) ?? 0)
                self.isMasterRelay.accept(isMaster)
            })
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] in
                guard let self else { return }
                let viewModel = self.configureViewModel(response: $0)
                self.presenter.configure(viewModel)
            }, onFailure: { [weak self] error in
                self?.presenter.showAlert(message: error.localizedDescription)
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    func viewDidLoad() {
        self.fetchMOITDetail(with: self.moitID)
    }
    
    func didRefresh() {
        self.fetchMOITDetail(with: self.moitID)
    }
    
    private func isMOITMasterUser(_ moitMasterID: String) -> Bool {
        self.isMasterUsecase.execute(with: Int(moitMasterID) ?? 0)
    }
    
    private func configureViewModel(response: MOITDetailEntity) -> MOITDetailViewModel {
        MOITDetailViewModel(
            moitImage: response.imageURL,
            moitName: response.moitName,
            moitDescription: response.description,
            moitInfos: self.moitInfosViewModel(
                scheduleDescription: response.scheduleDescription,
                ruleDescription: response.ruleShortDescription,
                periodDescription: response.periodDescription
            )
        )
    }
    
    private func moitInfosViewModel(
        buttonType: MOITDetailInfoViewButtonType = .fold,
        scheduleDescription: String,
        ruleDescription: String,
        periodDescription: String
    ) -> MOITDetailInfosViewModel {
        let infos = [
            MOITDetailInfoViewModel(
                title: "일정",
                description: scheduleDescription
            ),
            MOITDetailInfoViewModel(
                title: "규칙",
                description: ruleDescription
            ),
            MOITDetailInfoViewModel(
                title: "기간",
                description: periodDescription
            )
        ]
        return MOITDetailInfosViewModel(
            buttonType: buttonType,
            infos: infos
        )
    }
    
    func viewDidLayoutSubViews() {
        self.tabTypes.forEach { type  in
            switch type {
            case .attendance: self.router?.attachAttendance(moitID: self.moitID)
			case .fine: self.router?.attachFineList(moitID: Int(self.moitID) ?? 0)
            }
        }
    }
    
    func didTapParticipantsButton() {
        self.router?.attachMOITUsers(moitID: self.moitID)
    }
    
    func didTapShareButton() {
        guard let invitationCode else { return }
        self.router?.attachMOITShare(code: invitationCode)
    }
    
    func didTapPager(at index: Int) {
        print(#function, index)
    }
    
    func didSwipeBack() {
        self.listener?.moitDetailDidSwipeBack()
    }
    
    func didTapBackButton() {
        self.listener?.moitDetailDidTapBackButton()
    }
}

// MARK: - MOITDetailAttendance
extension MOITDetailInteractor {
    func didTapStudyView() {
        self.presenter.shouldLayout()
    }
    func didTapSegment() {
        self.presenter.shouldLayout()
    }
}

// MARK: - MOITUsers
extension MOITDetailInteractor {
    func moitUserDidTapBackButton() {
        self.router?.detachMOITUsers(withPop: true)
    }
    func moitUserDidSwipeBack() {
        self.router?.detachMOITUsers(withPop: false)
    }
}

// MARK: - MOITShare
extension MOITDetailInteractor {
    func didSuccessLinkCopy() {
        self.router?.detachMOITShare()
    }
    func didTapDimmedView() {
        self.router?.detachMOITShare()
    }
}

// MARK: - FineListListener
extension MOITDetailInteractor {
	func fineListViewDidTap(
		moitID: Int,
		fineID: Int,
		isMaster: Bool
	) {
		router?.attachAuthorizePayment(
			moitID: moitID,
			fineID: fineID,
			isMaster: isMaster
		)
	}
	
	func authorizePaymentDidSwipeBack() {
		router?.detachAuthorizePayment(completion: nil, withPop: false)
	}
	
	func authorizePaymentDismissButtonDidTap() {
		router?.detachAuthorizePayment(completion: nil, withPop: true)
	}
	
	/// 스터디원이 벌금 납부 인증 사진 등록 완료했을 때
	func didSuccessPostFineEvaluate() {
		router?.detachAuthorizePayment(completion: { [weak self] in
			self?.presenter.showToast(
				message: StringResource.successEvaluateFine.value,
				type: .success
			)
		}, withPop: true)
	}
	
	/// 스터디장이 벌금 납부 승인했을 때
	func didSuccessAuthorizeFine(isConfirm: Bool) {
		router?.detachAuthorizePayment(completion: { [weak self] in
			guard let self else { return }
			
			if isConfirm {
				self.presenter.showToast(
					message: StringResource.successConfirmFine.value,
					type: .success
				)
			} else {
				self.presenter.showToast(
					message: StringResource.successRejectFine.value,
					type: .fail
				)
			}
		}, withPop: true)
	}
}

extension MOITDetailInteractor {
	enum StringResource {
		case successConfirmFine
		case successRejectFine
		case successEvaluateFine
		
		var value: String {
			switch self {
			case .successConfirmFine:
				return "납부 완료 확인이 완료되었어요!"
			case .successRejectFine:
				// TODO: 닉네임 받아야함
				return "김모잇님께 납부 요청 알림이 다시 갔어요!"
			case .successEvaluateFine:
				return "벌금 납부 인증이 업로드되었어요!"
			}
		}
	}
}

// MARK: - MOITDetailActionableItem
extension MOITDetailInteractor: MOITDetailActionableItem {
    func routeToFine() -> Observable<(FineActionableItem, ())> {
        if let actionableItem = self.router?.attachFineList(moitID: Int(self.moitID) ?? 0) {
            return Observable.just((actionableItem, ()))
        } else { fatalError() }
    }
}
