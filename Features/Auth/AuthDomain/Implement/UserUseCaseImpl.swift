//
//  UserUseCaseImpl.swift
//  AuthDomainImpl
//
//  Created by 송서영 on 2023/08/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RxSwift
import AuthDomain
import AuthData
import TokenManager

public final class UserUseCaseImpl: UserUseCase {
    
    private let userRepository: UserRepository
    private let tokenManager: TokenManager
    
    public init(
        userRepository: UserRepository,
        tokenManager: TokenManager
    ) {
        self.userRepository = userRepository
        self.tokenManager = tokenManager
    }
    
    public func logout() -> Single<Void> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            if self.tokenManager.delete(key: .authorizationToken) {
                observer.onNext(())
                observer.onCompleted()
            } else {
                observer.onError(NSError(domain: "delete fail", code: 0))
            }
            return Disposables.create()
        }
        .asSingle()
    }
    
    public func withdraw() -> Single<Void> {
        self.userRepository.withdraw()
            .asObservable()
            .flatMap { [weak self] _ -> Observable<Void> in
                return Observable.create { [weak self] observer in
                    guard let self else { return Disposables.create() }
                    if self.tokenManager.delete(key: .authorizationToken) {
                        observer.onNext(())
                        observer.onCompleted()
                    } else {
                        observer.onError(NSError(domain: "delete fail", code: 0))
                    }
                    return Disposables.create()
                }
            }
            .asSingle()
    }
}
