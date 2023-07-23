//
//  MOITListInteractor.swift
//  MOITListUserInterfaceImpl
//
//  Created by kimchansoo on 2023/06/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import DesignSystem
import MOITListUserInterface
import MOITListDomain

import RIBs
import RxSwift
import RxRelay

protocol MOITListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MOITListPresentable: Presentable {
    var listener: MOITListPresentableListener? { get set }
    
    func didReceiveMOITList(moitList: [MOITPreviewViewModel]) // MOITList 받아오는
    func didReceiveAlarm(alarms: [AlarmViewModel])
}

protocol MOITListInteractorDependency {
    var fetchMOITListsUseCase: FetchMoitListUseCase { get }
    var fetchLeftTimeUseCase: FetchLeftTimeUseCase { get }
    var fetchPaneltyToBePaiedUSeCase: FetchPenaltyToBePaidUseCase { get }
//    var deleteMOITUseCase: DeleteMOITUseCase { get }
}

final class MOITListInteractor: PresentableInteractor<MOITListPresentable>, MOITListInteractable {
    
    // MARK: - Properties
    
    weak var router: MOITListRouting?
    weak var listener: MOITListListener?
    
    private let dependency: MOITListInteractorDependency
    
    private let selectedMoitIndex = PublishRelay<Int>()
    private let deleteMoitIndex = PublishRelay<Int>()
    private let selectedAlarmIndex = PublishRelay<Int>()
    private let createButtonTapped = PublishRelay<Void>()
    private let participateButtonTapped = PublishRelay<Void>()
    
    // MARK: - Initializers
    
    public init(
        presenter: MOITListPresentable,
        dependency: MOITListInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    // MARK: - Methods
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        bind()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    private func bind() {
        let moitList = dependency.fetchMOITListsUseCase.execute()
        
        // moitlist 보내주기
        moitList
            .subscribe(onSuccess: { [weak self] moitList in
                print("fetchMOITListsUseCase list: \(moitList)")
                
                let moitPreviewList = moitList.compactMap { self?.makeMoitPreview(with: $0)}
                self?.presenter.didReceiveMOITList(moitList: moitPreviewList)
            })
            .disposeOnDeactivate(interactor: self)
        
        // 알람 설정
        let fine = dependency.fetchPaneltyToBePaiedUSeCase.execute()
            .map {
                AlarmViewModel(
                    alarmType: .penalty(amount: $0.description),
                    studyName: ""
                )
            }
            .asObservable()
        
        let alertMoitInfo = moitList
            .compactMap { [weak self] moits in
                self?.dependency.fetchLeftTimeUseCase.execute(moitList: moits)
            }
            .map { moitName, date in
                AlarmViewModel(
                    alarmType: .attendanceCheck(
                        remainSeconds: Int(date.description) ?? 0
                    ),
                    studyName: moitName
                )
            }
            .asObservable()
        
        let alarmList = Observable.merge(fine, alertMoitInfo).toArray()
        
        alarmList
            .subscribe(onSuccess: { [weak self] alarms in
                self?.presenter.didReceiveAlarm(alarms: alarms)
            })
            .disposeOnDeactivate(interactor: self)
        
        // moit 삭제
        deleteMoitIndex
            .withLatestFrom(moitList) { index, moits in
                moits[index]
            }
            .withUnretained(self)
//            .flatMap { owner, deleteMoit in
//                print("deleteMoit: \(deleteMoit)")
////                return owner.dependency.deleteMOITUseCase.execute(moitId: deleteMoit.id)
//
//            }
            .subscribe(onNext: { owner, deleteMoit in
                print("성공")
            }, onError: { _ in
                print("실패")
            })
            .disposeOnDeactivate(interactor: self)
        
        // 선택된 moitdetail로 보내기
        selectedMoitIndex
            .withLatestFrom(moitList) { index, moits in
                moits[index]
            }
            .subscribe(onNext: { selectedMoit in
                // TODO: - MOITDetail로 보내기
                print("selectedMoit: \(selectedMoit)")
            })
            .disposeOnDeactivate(interactor: self)
        
        // 알람 탭
        selectedAlarmIndex
            .withLatestFrom(alarmList) { index, alarmList in
                alarmList[index]
            }
            .subscribe(onNext: { alarmViewModel in
                // TODO: - alarm 타입에 따라서 벌금, 출첵으로 나눠서 보내기
                print("alarmViewModel: \(alarmViewModel)")
            })
            .disposeOnDeactivate(interactor: self)
        
        // 생성하기로 보내기
        createButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                // TODO: - 생성하기로 보내기
            })
            .disposeOnDeactivate(interactor: self)
        
        // 참여하기로 보내기
        participateButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                // TODO: - 참여하기로 보내기
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    private func makeMoitPreview(with moit: MOIT) -> MOITPreviewViewModel {
        let description = "\(moit.repeatCycle)마다 \(moit.dayOfWeeks) \(moit.startTime) - \( moit.endTime)"
        return MOITPreviewViewModel(
            remainingDate: moit.dday,
            profileUrlString: moit.profileUrl,
            studyName: moit.name,
            studyProgressDescription: description
        )
    }
}

// MARK: - MOITListPresentableListener
extension MOITListInteractor: MOITListPresentableListener {
    
    func didTapDeleteMOIT(index: Int) {
        deleteMoitIndex.accept(index)
    }
    
    func didTapCreateButton() {
        createButtonTapped.accept(())
    }
    
    func didTapParticipateButton() {
        participateButtonTapped.accept(())
    }
    
    func didTapAlarm(index: Int) {
        selectedAlarmIndex.accept(index)
    }
    
    func didTapMOIT(index: Int) {
        self.selectedMoitIndex.accept(index)
    }
}
