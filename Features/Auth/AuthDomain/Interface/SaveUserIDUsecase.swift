//
//  SaveUserIDUsecase.swift
//  AuthDomain
//
//  Created by 최혜린 on 2023/07/28.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol SaveUserIDUseCase {
	func execute(userID: Int)
}
