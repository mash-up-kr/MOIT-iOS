//
//  FetchFineItemUseCase.swift
//  FineDomain
//
//  Created by 최혜린 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

public protocol FetchFineItemUseCase {
	func execute(moitID: Int, fineID: Int) -> Single<FineItemEntity>
}
