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

protocol MOITDetailRouting: ViewableRouting {
    func attachAttendance()
}

protocol MOITDetailPresentable: Presentable {
    var listener: MOITDetailPresentableListener? { get set }
    func configure(_ viewModel: MOITDetailViewModel)
    func update(infoViewModel: MOITDetailInfosViewModel)
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
    private let moitID: String
    
    private var scheduleDescription: String?
    private var longRuleDescription: String?
    private var shortRuleDescription: String?
    private var periodDescription: String?
    
    init(
        moitID: String,
        tabTypes: [MOITDetailTab],
        presenter: MOITDetailPresentable,
        detailUsecase: MOITDetailUsecase
    ) {
        self.moitID = moitID
        self.detailUsecase = detailUsecase
        self.tabTypes = tabTypes
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func viewDidLoad() {
        self.detailUsecase.moitDetail(with: self.moitID)
            .delay(
                .seconds(1),
                scheduler: MainScheduler.instance
            )
            .do(onSuccess: { [weak self] in
                self?.scheduleDescription = $0.scheduleDescription
                self?.longRuleDescription = $0.ruleLongDescription
                self?.shortRuleDescription = $0.ruleShortDescription
                self?.periodDescription = $0.periodDescription
            })
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] in
                guard let self else { return }
                let viewModel = self.configureViewModel(response: $0)
                self.presenter.configure(viewModel)
            }, onFailure: { error in
                // TODO: 에러 처리 필요
                print(error)
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    private func isMOITMasterUser(_ moitMasterID: String) -> Bool {
        //TODO: 로컬디비에서 내 아이디 가져오는 로직 필요
        let myID = "aaaa"
        return moitMasterID == myID
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
            case .attendance: self.router?.attachAttendance()
                // TODO: 혜린언니 TODO입니당 !
            case .fine: print("벌금 붙이는 작업 해야됨")
            }
        }
    }
    
    func didTapParticipantsButton() {
        print(#function)
    }
    func didTapShareButton() {
        print(#function)
    }
    func didTapPager(at index: Int) {
        print(#function, index)
    }
}
