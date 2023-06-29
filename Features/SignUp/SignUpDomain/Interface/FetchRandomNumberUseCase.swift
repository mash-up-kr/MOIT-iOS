//
//  FetchRandomNumberUseCase.swift
//  SignUpDomain
//
//  Created by 김찬수 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol FetchRandomNumberUseCase {
    func execute(with range: Range<Int>) -> Int
}
