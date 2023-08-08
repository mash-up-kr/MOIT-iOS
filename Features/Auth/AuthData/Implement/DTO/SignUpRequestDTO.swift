//
//  SignUpRequestDTO.swift
//  AuthData
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import TokenManagerImpl

struct SignUpRequestDTO: Encodable {
    let providerUniqueKey: String
    let nickname: String
    let email: String
    let profileImage: Int
    var moitInvitationCode: String?
    let fcmToken: String?
    
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
        self.moitInvitationCode = inviteCode
        self.fcmToken = TokenManagerImpl().get(key: .fcmToken)
    }
}
