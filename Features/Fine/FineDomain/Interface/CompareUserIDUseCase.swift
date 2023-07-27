//
//  CompareUserIDUseCase.swift
//  FineDomain
//
//  Created by 최혜린 on 2023/07/27.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol CompareUserIDUseCase {
	func execute(with iD: Int) -> Bool
}
