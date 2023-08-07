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
	
	func fetchFineInfo(moitID: Int) -> Single<FineInfo>
	func fetchFineItem(moitID: Int, fineID: Int) -> Single<FineItem>
	// TODO: EmptyDTO로 변경 필요
	func postFineEvaluate(moitID: Int, fineID: Int, data: Data?) -> Single<FineItem?>
	func postAuthorizeFine(moitID: Int, fineID: Int, isConfirm: Bool) -> Single<Bool?>
}
