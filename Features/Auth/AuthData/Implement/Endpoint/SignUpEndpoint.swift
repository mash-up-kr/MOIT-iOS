//
//  SignUpEndpoint.swift
//  AuthData
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITNetwork

enum SignUpEndpoint {
    
    static func signUp(dto: SignUpRequestDTO) -> Endpoint<TokenDTO> {
        return Endpoint<TokenDTO>(
            path: "auth/signup",
            method: .post,
            parameters: .body(dto)
        )
    }

}
