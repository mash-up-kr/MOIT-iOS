//
//  FetchTokenUseCase.swift
//  AuthDomain
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol FetchTokenUseCase {
    
    // MARK: - Methods
    func execute() -> String?
}
