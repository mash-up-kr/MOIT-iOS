//
//  PostFineEvaluateUseCase.swift
//  FineDomain
//
//  Created by 최혜린 on 2023/07/30.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import FineData
import RxSwift

public protocol PostFineEvaluateUseCase {
	func execute(moitID: Int, fineID: Int, data: Data?) -> Single<FineItem?>
}
