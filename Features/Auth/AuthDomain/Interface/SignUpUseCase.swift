//
//  SignUpUseCase.swift
//  AuthDomain
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

public protocol SignUpUseCase {
    
    func execute(
        providerUniqueKey: String,
        imageIndex: Int,
        nickName: String,
        email: String,
        inviteCode: String?
    ) -> Single<String>
}
