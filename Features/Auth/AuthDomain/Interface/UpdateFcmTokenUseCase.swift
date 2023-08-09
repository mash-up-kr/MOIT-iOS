//
//  UpdateFcmTokenUseCase.swift
//  AuthDomain
//
//  Created by kimchansoo on 2023/08/09.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

public protocol UpdateFcmTokenUseCase {
    
    func execute(token: String) -> Single<Void>
}

