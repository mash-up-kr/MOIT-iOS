//
//  UserInfoDTO.swift
//  AuthData
//
//  Created by 최혜린 on 2023/07/28.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

// MARK: - UserInfoDTO
public struct UserInfoDTO: Codable {
	public let id: Int
	public let providerUniqueKey, nickname: String
	public let profileImage: Int
	public let email: String
	public let roles: [String]
}
