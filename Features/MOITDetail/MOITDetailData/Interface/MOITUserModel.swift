//
//  MOITUserModel.swift
//  MOITDetailData
//
//  Created by 송서영 on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOITUserModel: Codable {
    public let users: [User]
    
    public struct User: Codable {
        public let userID: Int
        public let nickname: String
        public let profileImage: Int
        public let isMaster: Bool
        
        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case nickname, profileImage, isMaster
        }
    }
    
}
