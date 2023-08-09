//
//  UpdateFcmTokenUseCaseImpl.swift
//  AuthDomain
//
//  Created by kimchansoo on 2023/08/09.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthData
import AuthDomain

import RxSwift

public final class UpdateFcmTokenUseCaseImpl: UpdateFcmTokenUseCase {
    
    // MARK: - Properties
    
    private let userRepository: UserRepository
    
    // MARK: - Initializers
    
    public init(
        userRepository: UserRepository
    ) {
        self.userRepository = userRepository
    }
    
    // MARK: - Methods
    
    public func execute(token: String) -> Single<Void> {
        self.userRepository.updateFcmToken(token: token)
    }
}
