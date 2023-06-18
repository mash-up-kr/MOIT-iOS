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

    init(
        tabTypes: [MOITDetailTab],
        presenter: MOITDetailPresentable
    ) {
        self.tabTypes = tabTypes
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.presenter.configure(
                MOITDetailViewModel(
                    moitImage: "",
                    moitName: "전자군단 스터디",
                    moitDescription: "매시업 IT 개발 동아리 WEB&iOS 팀 !!",
                    moitInfos: .init(
                buttonType: .fold,
                infos: [
                    .init(title: "일정", description: "격주 금요일 17:00-20:00"),
                    .init(title: "규칙", description: "지각 15분부터 5,000원")
                ]
            )))
        }
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func viewDidLoad() {
       
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
