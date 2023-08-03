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
import AuthDomain
import RIBs
import RxSwift
import RxRelay

protocol MOITListRouting: ViewableRouting {
    func attachRegisterMOIT()
    func detachRegisterMOIT(withPop: Bool)
    func attachMOITDetail(id: String)
    func detachMOITDetail(withPop: Bool)
    func attachInputParticipateCode()
    func detachInputParticipateCode()
    func attachSetting()
    func detachSetting(withPop: Bool)
}

protocol MOITListPresentable: Presentable {
    var listener: MOITListPresentableListener? { get set }
    
    func didReceiveMOITList(moitList: [MOITPreviewViewModel]) // MOITList 받아오는
    func didReceiveAlarm(alarms: [AlarmViewModel])
}

protocol MOITListInteractorDependency {
    var fetchMOITListsUseCase: FetchMoitListUseCase { get }
    var fetchBannersUseCase: FetchBannersUseCase { get }
    var calculateLeftTimeUseCase: CalculateLeftTimeUseCase { get }
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
        // TODO: - 알람 로직 수정
        
        let bannerInfos = dependency.fetchBannersUseCase.execute()
        
        let alarmList = bannerInfos
            .map { [weak self] banners -> [AlarmViewModel] in
                return banners.compactMap { self?.makeAlarmView(with: $0) }
            }

        
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
            .subscribe(onNext: { [weak self] selectedMoit in
                self?.router?.attachMOITDetail(id: "\(selectedMoit)")
            })
            .disposeOnDeactivate(interactor: self)
        
        // 알람 탭
        selectedAlarmIndex
            .withLatestFrom(bannerInfos) { index, bannerInfos in
                bannerInfos[index]
            }
            .subscribe(onNext: { bannerInfo in
                // TODO: - alarm 타입에 따라서 벌금, 출첵으로 나눠서 보내기
                print("bannerInfo: \(bannerInfo)")
                switch bannerInfo {
                case .fine(let banner):
                    // 화면 전환
                    fatalError("화면 전환")
                case .attendence(let banner):
                    // 화면 전환
                    fatalError("화면 전환")
                case .empty:
                    return
                }
            })
            .disposeOnDeactivate(interactor: self)
        
        // 생성하기로 보내기
        createButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.router?.attachRegisterMOIT()
            })
            .disposeOnDeactivate(interactor: self)
        
        // 참여하기로 보내기
        participateButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.router?.attachInputParticipateCode()
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
    
    // banner -> AlarmViewModel 함수
    private func makeAlarmView(with banner: Banner) -> AlarmViewModel {
        switch banner {
        case .attendence(let attendenceBanner):
            let remainSecond = self.dependency.calculateLeftTimeUseCase.execute(
                startTime: attendenceBanner.studyStartAt,
                lateTime: attendenceBanner.studyLateAt,
                absenceTime: attendenceBanner.studyAbsenceAt
            )
            return AlarmViewModel(alarmType: .attendanceCheck(remainSeconds: remainSecond), studyName: attendenceBanner.moitName)
        case .fine(let fineBanner):
            return AlarmViewModel(
                alarmType: .penalty(
                    amount: fineBanner.fineAmount.description),
                studyName: fineBanner.moitName
            )
        case .empty:
            return AlarmViewModel(alarmType: .penalty(amount: ""), studyName: "스터디 화이팅")
        }
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
    
    func didTapSetting() {
        router?.attachSetting()
    }
}

// MARK: - MOITWebListener

extension MOITListInteractor {
    func didSignIn(with token: String) {
    }
    func authorizationDidFinish(with signInResponse: MOITSignInResponse) {
    }
    func shouldDetach(withPop: Bool) {
        self.router?.detachRegisterMOIT(withPop: withPop)
    }
}

// MARK: - MOITSettingListener

extension MOITListInteractor {
    func didTapBackButton() {
        self.router?.detachSetting(withPop: true)
    }
    func didSwipeBack() {
        self.router?.detachSetting(withPop: false)
    }
}

// MARK: - MOITDetail
extension MOITListInteractor {
    func moitDetailDidSwipeBack() {
        self.router?.detachMOITDetail(withPop: false)
    }
    
    func moitDetailDidTapBackButton() {
        self.router?.detachMOITDetail(withPop: true)
    }
}

// MARK: - InputParticiateCode
extension MOITListInteractor {
    func inputParticiateCodeDidTapBack() {
        self.router?.detachInputParticipateCode()
    }
}
