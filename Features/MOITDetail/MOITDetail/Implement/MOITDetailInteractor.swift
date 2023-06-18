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
}

final class MOITDetailInteractor: PresentableInteractor<MOITDetailPresentable>,
                                  MOITDetailInteractable,
                                  MOITDetailPresentableListener {
    
    func didTapInfoButton(type: MOITDetailInfoViewButtonType) {
        
    }

    weak var router: MOITDetailRouting?
    weak var listener: MOITDetailListener?
    
    private let tabTypes: [MOITDetailTab]
    private let detailUsecase: MOITDetailUsecase
    
    init(
        tabTypes: [MOITDetailTab],
        presenter: MOITDetailPresentable,
        detailUsecase: MOITDetailUsecase
    ) {
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
        self.detailUsecase.moitDetail(with: "testID")
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self else { return }
                self.presenter.configure(
                    MOITDetailViewModel(
                        moitImage: response.imageURL,
                        moitName: response.moitName,
                        moitDescription: response.description,
                        moitInfos: self.moitInfosViewModel(
                            scheduleDescription: response.scheduleDescription,
                            ruleDescription: response.ruleLongDescription,
                            periodDescription: response.periodDescription
                        )
                    )
                )
            },onFailure: { error in
                print(error)
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    private func isMOITMasterUser(_ moitMasterID: String) -> Bool {
        //TODO: 내 아이디 가져오는 로직 필요
        let myID = "aaaa"
        return moitMasterID == myID
    }
    private func moitInfosViewModel(scheduleDescription: String, ruleDescription: String, periodDescription: String) -> MOITDetailInfosViewModel {
        MOITDetailInfosViewModel(buttonType: .fold, infos: [
            MOITDetailInfoViewModel(title: "일정", description: scheduleDescription),
            MOITDetailInfoViewModel(title: "규칙", description: ruleDescription),
            MOITDetailInfoViewModel(title: "기간", description: periodDescription),
        ])
    }
    func viewDidLayoutSubViews() {
        self.tabTypes.forEach { type  in
            switch type {
            case .attendance: self.router?.attachAttendance()
            default: return
            }
        }
    }
}
