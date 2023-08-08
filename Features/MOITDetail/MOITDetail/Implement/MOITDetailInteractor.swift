//
//  MOITDetailInteractor.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import MOITDetail
import Foundation
import MOITDetailDomain
import RxRelay
import FineUserInterface
import FineDomain

protocol MOITDetailRouting: ViewableRouting {
    func attachAttendance(moitID: String)
    func attachMOITUsers(moitID: String)
    func detachMOITUsers(withPop: Bool)
    func attachMOITShare(code: String)
    func detachMOITShare()
    @discardableResult
    func attachFineList(moitID: Int) -> FineActionableItem?
}

protocol MOITDetailPresentable: Presentable {
    var listener: MOITDetailPresentableListener? { get set }
    func configure(_ viewModel: MOITDetailViewModel)
    func update(infoViewModel: MOITDetailInfosViewModel)
    func showAlert(message: String)
    func shouldLayout()
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

// MARK: - MOITDetailActionableItem

extension MOITDetailInteractor: MOITDetailActionableItem {
    func routeToFine() -> Observable<(FineActionableItem, ())> {
        if let actionableItem = self.router?.attachFineList(moitID: Int(self.moitID) ?? 0) {
            return Observable.just((actionableItem, ()))
        } else { fatalError() }
    }
}
