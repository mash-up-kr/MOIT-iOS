//
//  SignUpUseCaseImpl.swift
//  AuthDomain
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthDomain
import AuthData

import RxSwift

public final class SignUpUseCaseImpl: SignUpUseCase {
    
    // MARK: - Properties
    
    private let authRepository: AuthRepository
    
    // MARK: - Initializers
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    // MARK: - Methods
    
    public func execute(
        providerUniqueKey: String,
        imageIndex: Int,
        nickName: String,
        email: String,
        inviteCode: String?
    ) -> Single<String> {
        authRepository.signUp(
            providerUniqueKey: providerUniqueKey,
            imageIndex: imageIndex,
            nickName: nickName,
            email: email,
            inviteCode: inviteCode
        )
    }
}
