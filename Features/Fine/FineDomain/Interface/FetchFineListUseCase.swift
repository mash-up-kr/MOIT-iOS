//
//  FetchFineInfoUseCase.swift
//  FineDomain
//
//  Created by 최혜린 on 2023/07/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

public protocol FetchFineInfoUseCase {
	func execute(moitID: Int) -> Single<FineInfoEntity>
}
