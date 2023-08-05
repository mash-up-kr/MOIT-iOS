//
//  UserEndpoint.swift
//  AuthDataImpl
//
//  Created by 최혜린 on 2023/07/28.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITNetwork
import AuthData

enum UserEndpoint {
	static func fetchUserInfo() -> Endpoint<UserInfoDTO> {
		return Endpoint(
			path: "/api/v1/user",
			method: .get
		)
	}
    
    static func withdraw() -> Endpoint<EmptyResponse> {
        return Endpoint(
            path: "/api/v1/user",
            method: .delete
        )
    }
}
