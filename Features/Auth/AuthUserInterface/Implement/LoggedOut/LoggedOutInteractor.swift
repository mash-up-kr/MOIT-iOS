//
//  LoggedOutInteractor.swift
//  SignInUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import AuthUserInterface
import AuthDomain

import RIBs
import RxSwift

protocol LoggedOutRouting: ViewableRouting {
	
    func attachSignInWeb()
	func detachSignInWeb()
    
	func routeToSignUp(with response: MOITSignInResponse)
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
}

public protocol LoggedOutInteractorDependency: AnyObject {
	var saveTokenUseCase: SaveTokenUseCase { get }
	var fetchUserInfoUseCase: FetchUserInfoUseCase { get }
	var saveUserIDUseCase: SaveUserIDUseCase { get }
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {
    
    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?
    
    private let dependency: LoggedOutInteractorDependency
    
    init(
        presenter: LoggedOutPresentable,
        dependency: LoggedOutInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
}

// MARK: - LoggedOutPresenterListener

extension LoggedOutInteractor {
    func signInButtonDidTap() {
        router?.attachSignInWeb()
    }
}

// MARK: - MOITWebListenter

extension LoggedOutInteractor {
    func shouldDetach(withPop: Bool) {
        router?.detachSignInWeb()
    }
    
    func authorizationDidFinish(with signInResponse: MOITSignInResponse) {
        router?.routeToSignUp(with: signInResponse)
    }
    
    func didSignIn(with token: String) {
        self.router?.detachSignInWeb()
        dependency.saveTokenUseCase.execute(token: token)
        dependency.fetchUserInfoUseCase.execute()
            .debug(":")
            .do(onSuccess: { [weak self] entity in
                self?.dependency.saveUserIDUseCase.execute(userID: entity.userID)
            })
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                    self?.listener?.didCompleteAuth()
                }
            )
            .disposeOnDeactivate(interactor: self)
    }
}

// MARK: - SignUp
extension LoggedOutInteractor {
    func didCompleteSignUp() {
        router?.detachSignInWeb()
        listener?.didCompleteAuth()
    }
}
