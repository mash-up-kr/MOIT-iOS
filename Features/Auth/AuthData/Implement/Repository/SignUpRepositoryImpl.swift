//
//  SignUpRepository.swift
//  AuthData
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITNetwork
import AuthData

import RxSwift

public final class AuthRepositoryImpl: AuthRepository {    

    // MARK: - Properties
    
    let network: Network
    
    // MARK: - Initializers
    
    public init(network: Network) {
        self.network = network
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    public func signUp(
        providerUniqueKey: String,
        imageIndex: Int,
        nickName: String,
        email: String,
        inviteCode: String?
    ) -> Single<String> {
        var inviteCode = inviteCode
        if inviteCode == "" {
            inviteCode = nil
        }
        
        let dto = SignUpRequestDTO(
            providerUniqueKey: providerUniqueKey,
            nickname: nickName,
            email: email,
            profileImage: imageIndex,
            inviteCode: inviteCode
        )
        let endpoint = SignUpEndpoint.signUp(dto: dto)
        return network.request(with: endpoint)
			.compactMap { $0?.token }.asObservable().asSingle()
    }
}
