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
	let id: Int
	let providerUniqueKey, nickname: String
	let profileImage: Int
	let email: String
	let roles: [String]
}
