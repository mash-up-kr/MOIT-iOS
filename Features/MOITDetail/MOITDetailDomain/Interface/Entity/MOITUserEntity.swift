//
//  MOITUserEntity.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOITUserEntity {
    public let userID: String
    public let nickname: String
    public let profileImage: Int
    
    public init(
        userID: String,
        nickname: String,
        profileImage: Int
    ) {
        self.userID = userID
        self.nickname = nickname
        self.profileImage = profileImage
    }
}
