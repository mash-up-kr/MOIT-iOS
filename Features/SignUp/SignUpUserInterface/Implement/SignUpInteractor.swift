//
//  SignUpInteractor.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import SignUpUserInterface
import SignUpData
import SignUpDomain

import RIBs
import RxSwift
import RxCocoa

protocol SignUpRouting: ViewableRouting {
    
    func attachMOITList()
    func attachProfileSelect()
}

protocol SignUpPresentable: Presentable {
    
    var listener: SignUpPresentableListener? { get set }
    
    func updateProfileIndex(index: Int)
}

protocol SignUpInteractorDependency {
    var fetchRandomNumberUseCase: FetchRandomNumberUseCase { get }
    var postJoinInfoUseCase: PostJoinInfoUseCase { get }
}

final class SignUpInteractor: PresentableInteractor<SignUpPresentable>, SignUpInteractable {
    
    // MARK: - Properties
    weak var router: SignUpRouting?
    weak var listener: SignUpListener?
    
    private let dependency: SignUpInteractorDependency
    
    private let nickName = PublishRelay<String>()
    private let inviteCode = PublishRelay<String>()
    private let nextButtonTapped = PublishRelay<Void>()
    
    // MARK: - Initializers
    public init(
        presenter: SignUpPresentable,
        dependency: SignUpInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    // MARK: - Lifecycle
    override func didBecomeActive() {
        super.didBecomeActive()
        
        bind()
        presenter.updateProfileIndex(index: dependency.fetchRandomNumberUseCase.execute(with: 0 ..< 8))
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - Functions
    private func bind() {
        // nextButtonTapped가 발동 시 nickname과 inviteCode 스트림을 합쳐서 postJoinInfoUseCase에 전달
        nextButtonTapped
            .withLatestFrom(Observable.combineLatest(nickName, inviteCode))
            .flatMap { [weak self] nickName, inviteCode -> Single<Int> in
                guard let self = self else { return }
                // id 반환
                print("nickname: \(nickName)")
                print("inviteCode: \(inviteCode)")
                // TODO: - 받은 내 ID 저장
                return self.dependency.postJoinInfoUseCase.execute(name: nickName, inviteCode: inviteCode)
            }
            .subscribe(onNext: {})
//            .subscribe(onNext: { [weak self] nickName, inviteCode in
//                guard let self = self else { return }
//                // id 반환
//                print("nickname: \(nickName)")
//                print("inviteCode: \(inviteCode)")
//                // TODO: - 받은 내 ID 저장
//                self.dependency.postJoinInfoUseCase.execute(name: nickName, inviteCode: inviteCode)
//            })
            .disposeOnDeactivate(interactor: self)
            
    }
}

// MARK: - SignUpPresentableListener
extension SignUpInteractor: SignUpPresentableListener {
    
    func didSwipeBack() {
        
    }
    
    func didTapNextButton() {
        nextButtonTapped.accept(())
    }
    
    func didTapProfileView() {
        router?.attachProfileSelect()
    }
    
    func didTypeName(name: String) {
        self.nickName.accept(name)
    }
    
    func didTypeInviteCode(inviteCode: String) {
        self.inviteCode.accept(inviteCode)
    }
}

