//
//  PostMasterAuthorizeUseCase.swift
//  FineDomain
//
//  Created by 최혜린 on 2023/07/30.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

public protocol PostMasterAuthorizeUseCase {
	func execute(moitID: Int, fineID: Int, isConfirm: Bool) -> Single<Bool?>
}
