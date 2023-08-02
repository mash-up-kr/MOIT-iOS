//
//  FetchTokenUseCaseImpl.swift
//  AuthDomain
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthDomain
import TokenManager

public final class FetchTokenUseCaseImpl: FetchTokenUseCase {
    
    // MARK: - Properties
    
    private let tokenManager: TokenManager
    
    // MARK: - Initializers
    
    public init(
        tokenManager: TokenManager
    ) {
        self.tokenManager = tokenManager
    }
    
    // MARK: - Methods
    public func execute() -> String? {
        self.tokenManager.get(key: .authorizationToken)
    }
}
