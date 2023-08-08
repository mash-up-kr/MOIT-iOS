//
//  SignUpInteractor.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import AuthUserInterface
import AuthData
import AuthDomain
import MOITListUserInterface
import DesignSystem
import Utils

import RIBs
import RxSwift
import RxCocoa

protocol SignUpRouting: ViewableRouting {
    
    func attachProfileSelect(currentImageIndex: Int?)
    func detachProfileSelect()
}

protocol SignUpPresentable: Presentable {
    
    var listener: SignUpPresentableListener? { get set }
    
    func updateProfileIndex(index: Int)
}

protocol SignUpInteractorDependency {
    var fetchRandomNumberUseCase: FetchRandomNumberUseCase { get }
    var signUpUseCase: SignUpUseCase { get }
    var signInResponse: MOITSignInResponse { get }
    var saveTokenUseCase: SaveTokenUseCase { get }
}

final class SignUpInteractor: PresentableInteractor<SignUpPresentable>,
                              SignUpInteractable {
    
    // MARK: - Properties
    weak var router: SignUpRouting?
    weak var listener: SignUpListener?
    
    private let dependency: SignUpInteractorDependency
    
    private let profileImageIndex = PublishRelay<Int>()
    private let nickName = PublishRelay<String>()
    private let inviteCode = PublishRelay<String>()
    private let nextButtonTapped = PublishRelay<Void>()
    private let profileViewTapped = PublishRelay<Void>()
    
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
        configureImageType()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    // MARK: - Functions
    private func configureImageType() {
        self.profileImageIndex.accept(dependency.fetchRandomNumberUseCase.execute(with: 0..<9))
    }
    
    private func bind() {
        // nextButtonTapped가 발동 시 nickname과 inviteCode 스트림을 합쳐서 postJoinInfoUseCase에 전달
        nextButtonTapped
            .withLatestFrom(Observable.combineLatest(profileImageIndex, nickName, inviteCode))
            .distinctUntilChanged({ old, new in
                return old.0 == new.0 && old.1 == new.1
            })
            .flatMap { [weak self] profileImageIndex, nickName, inviteCode -> Observable<String> in
                guard let self else { return .empty() }
                print("profileImageIndex, nickName, inviteCode: ", profileImageIndex, nickName, inviteCode)
                return self.dependency.signUpUseCase.execute(
                    providerUniqueKey: self.dependency.signInResponse.providerUniqueKey,
                    imageIndex: profileImageIndex,
                    nickName: nickName,
                    email: self.dependency.signInResponse.email,
                    inviteCode: inviteCode
                )
                .asObservable()
            }
            .observe(on: MainScheduler.instance)
        // 성공하면 화면 moitlist로, 실패하면 처리 따로
            .subscribe(
                onNext: { [weak self] token in
                    
                    // 토큰 저장
                    self?.dependency.saveTokenUseCase.execute(token: token)
                    // 뷰 옮기기
                    self?.listener?.didCompleteSignUp()
                },
                onError: { error in
                    // TODO: - 중복된 닉네임이거나 이미 회원가입된 아이디입니다.
                    print(error)
                }
            )
            .disposeOnDeactivate(interactor: self)
        
        profileImageIndex
            .withUnretained(self)
            .subscribe(onNext: { owner, index in
                // 이미지 업데이트
                owner.presenter.updateProfileIndex(index: index)
            })
            .disposeOnDeactivate(interactor: self)
        
        profileViewTapped
            .withLatestFrom(profileImageIndex)
            .withUnretained(self)
            .debug()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { owner, index in
                owner.router?.attachProfileSelect(currentImageIndex: index)
            })
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
        profileViewTapped.accept(())
    }
    
    func didTypeName(name: String) {
        self.nickName.accept(name)
    }
    
    func didTypeInviteCode(inviteCode: String) {
        self.inviteCode.accept(inviteCode)
    }
}

// MARK: - ProfileSelectListener
extension SignUpInteractor: ProfileSelectListener {
    
    func profileSelectDidClose() {
        router?.detachProfileSelect()
    }
    
    func profileSelectDidFinish(imageTypeIdx: Int) {
        profileImageIndex.accept(imageTypeIdx)
        router?.detachProfileSelect()
    }
}

extension SignUpInteractor: AdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss() {
        router?.detachProfileSelect()
    }
}
