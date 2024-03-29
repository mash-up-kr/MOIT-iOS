//
//  FetchRandomNumberUseCaseImpl.swift
//  SignUpDomain
//
//  Created by 김찬수 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthDomain

public final class FetchRandomNumberUseCaseImpl: FetchRandomNumberUseCase {
    
    public init() {
    }
    
    public func execute(with range: Range<Int>) -> Int {
        return Int.random(in: range)
    }
}
