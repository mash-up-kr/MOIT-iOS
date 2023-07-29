//
//  SignUpRequestDTO.swift
//  AuthData
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

struct SignUpRequestDTO: Encodable {
    let providerUniqueKey: String
    let nickname: String
    let email: String
    let profileImage: Int
    let inviteCode: String?
    
    init(
        providerUniqueKey: String,
        nickname: String,
        email: String,
        profileImage: Int,
        inviteCode: String?
    ) {
        self.providerUniqueKey = providerUniqueKey
        self.nickname = nickname
        self.email = email
        self.profileImage = profileImage
        self.inviteCode = inviteCode
    }
}
