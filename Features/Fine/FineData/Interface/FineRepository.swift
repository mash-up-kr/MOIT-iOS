//
//  FineRepository.swift
//  FineData
//
//  Created by 최혜린 on 2023/07/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

public protocol FineRepository {
	
	func fetchFineInfo(moitID: String) -> Single<FineInfo>
}
