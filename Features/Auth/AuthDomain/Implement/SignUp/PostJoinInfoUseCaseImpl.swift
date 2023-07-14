//
//  PostJoinInfoUseCaseImpl.swift
//  SignUpDomain
//
//  Created by 김찬수 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import SignUpData
import SignUpDomain

import RxSwift

public final class PostJoinInfoUseCaseImpl: PostJoinInfoUseCase {
    // MARK: - UI
    
    // MARK: - Properties
    private let joinRepository: JoinRepository
    
    // MARK: - Initializers
    public init(joinRepository: JoinRepository) {
        self.joinRepository = joinRepository
    }
    
    // MARK: - Functions
    public func execute(imageIndex: Int, name: String, inviteCode: String?) -> Single<Int> {
        return joinRepository.post(imageIndex: imageIndex, name: name, inviteCode: inviteCode)
    }
}
