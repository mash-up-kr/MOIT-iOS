//
//  MOITShareUsecase.swift
//  MOITShareDomain
//
//  Created by 송서영 on 2023/07/27.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RxSwift

public protocol MOITShareUsecase {
    func copyLink(_ link: String) -> Single<Void>
}
