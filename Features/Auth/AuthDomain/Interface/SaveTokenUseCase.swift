//
//  SaveTokenUseCase.swift
//  AuthDomain
//
//  Created by 최혜린 on 2023/07/27.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol SaveTokenUseCase {
	func execute(token: String)
}
