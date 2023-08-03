//
//  MOITListViewController.swift
//  MOITListUserInterfaceImpl
//
//  Created by kimchansoo on 2023/06/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import DesignSystem
import MOITListUserInterface
import MOITListDomain
import Utils

import ResourceKit
import RIBs
import RxSwift
import UIKit
import FlexLayout
import PinLayout

protocol MOITListPresentableListener: AnyObject {
    
    func didTapMOIT(index: Int) // MOIT 하나 탭 시 불리는 함수
    func didTapDeleteMOIT(index: Int) // MOIT 하나 삭제 시 불리는 함수
    func didTapAlarm(index: Int)
    func didTapSetting()
    func didTapCreateButton()
    func didTapParticipateButton()
}

final class MOITListViewController: BaseViewController, MOITListPresentable, MOITListViewControllable {
    
    // MARK: - UI
    private let alarmRootView = UIView()
    private let pagableAlarmView = PagableCollectionView(frame: .zero)
    
    private let listRootView = UIView()
    
    
    private let moitTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 스터디"
        label.textColor = ResourceKitAsset.Color.gray800.color
        label.font = ResourceKitFontFamily.h6
        return label
    }()
    
    private let moitCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = ResourceKitAsset.Color.blue600.color
        label.font = ResourceKitFontFamily.h6
        return label
    }()
    
    private let emptyMOITView = EmptyMOITView()
    
    private var moitPreviewList: [MOITStudyPreview] = []
    
    private let createButton = MOITButton(
        type: .small,
        title: "스터디 생성",
        titleColor: ResourceKitAsset.Color.gray800.color,
        backgroundColor: ResourceKitAsset.Color.gray200.color
    )
    
    private let participateButton = MOITButton(
        type: .small,
        title: "스터디 참여",
        titleColor: ResourceKitAsset.Color.white.color,
        backgroundColor: ResourceKitAsset.Color.blue800.color
    )
    
    // MARK: - Properties
    weak var listener: MOITListPresentableListener?
    
    private lazy var moitList: [MOITList] = []
    
    // MARK: - Initializers
    public init(listener: MOITListPresentableListener? = nil) {
        self.listener = listener
        super.init()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ResourceKitAsset.Color.gray100.color
        self.flexRootView.backgroundColor = ResourceKitAsset.Color.gray100.color
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureNavigationBar(
            leftItems: [.logo],
            title: "",
            rightItems: [
                .alarm,
                .setting
            ]
        )
    }
    
    // MARK: - Methods
    override func configureConstraints() {
        super.configureConstraints()
        
        flexRootView.flex
            .paddingHorizontal(20)
            .paddingTop(20)
            .define { flex in
                // 알람
                flex.addItem(alarmRootView)
                    .marginBottom(30)
                
                // 모잇 몇개인지
                flex.addItem()
                    .direction(.row)
                    .define { flex in
                        flex.addItem(moitTitleLabel)
                            .marginRight(4)
                        flex.addItem(moitCountLabel)
                    }
                    .marginBottom(20)
                
                // 모잇 리스트
                flex.addItem(listRootView)
                    .define({ flex in
                        flex.addItem(emptyMOITView)
                            .height(108)
                            .width(100%)
                    })
                
                // 참여, 생성 버튼
                flex.addItem()
                    .direction(.row)
                    .justifyContent(.spaceBetween)
                    .define { flex in
                        flex.addItem(createButton)
                            .width(47%)
                        flex.addItem(participateButton)
                            .width(47%)
                    }
            }
    }
    
    override func bind() {
        super.bind()
        
        navigationBar.rightItems?[1].rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.listener?.didTapSetting()
            })
            .disposed(by: disposebag)
              
        pagableAlarmView.thumbnailDidTap.asObservable()
            .withUnretained(self)
            .subscribe(onNext: { owner, index in
                owner.listener?.didTapAlarm(index: index.row)
            })
            .disposed(by: disposebag)
        
        
        createButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.listener?.didTapCreateButton()
            })
            .disposed(by: disposebag)
        
        participateButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.listener?.didTapParticipateButton()
            })
            .disposed(by: disposebag)
        
        moitPreviewList.enumerated().forEach { index, preview in
            // 탭
            preview.rx.didTap
                .withUnretained(self)
                .subscribe(onNext: { owner, _ in
                    owner.listener?.didTapMOIT(index: index)
                })
                .disposed(by: disposebag)
            
            // 삭제
            preview.rx.didConfirmDelete
                .withUnretained(self)
                .subscribe(onNext: { owner, _ in
                    owner.listener?.didTapDeleteMOIT(index: index)
                })
                .disposed(by: disposebag)
        }
    }
    
    func didReceiveMOITList(moitList: [MOITPreviewViewModel]) {
        print(#function, "previewViewModel: \(moitList)")
        
        if moitList.isEmpty { return }
        
        moitCountLabel.text = moitList.count.description
        moitCountLabel.flex.markDirty()
        
        emptyMOITView.flex.display(.none)
        
        // TODO: - studypreview 모아서 저장해두고 걔를 additem
        let moitPreviewList = moitList.map { makeStudyPreview(with: $0) }
        self.moitPreviewList = moitPreviewList
        
        listRootView.flex.define { flex in
            moitPreviewList.forEach {
                flex.addItem($0)
                    .height(100)
                    .width(100%)
                    .marginBottom(10)
            }
        }
        listRootView.flex.markDirty()
        listRootView.flex.layout()
        flexRootView.flex.layout()
    }
    
    func didReceiveAlarm(alarms: [AlarmViewModel]) {
        
        self.pagableAlarmView.configure(alarmViewModels: alarms)
        
        alarmRootView.flex.define { flex in
            flex.addItem(pagableAlarmView)
        }
        
        // TODO: - flexRootView.flex.layout만 해도 레이아웃 잡히는지 실 데이터 받을 때 확인
        pagableAlarmView.flex.markDirty()
        alarmRootView.flex.markDirty()
        flexRootView.flex.layout()
    }
    
}

private extension MOITListViewController {
    func makeStudyPreview(with viewModel: MOITPreviewViewModel) -> MOITStudyPreview {
        MOITStudyPreview(
            remainingDate: viewModel.remainingDate,
            profileURLString: viewModel.profileUrlString,
            studyName: viewModel.studyName,
            studyProgressDescription: viewModel.studyProgressDescription
        )
    }
    
}
