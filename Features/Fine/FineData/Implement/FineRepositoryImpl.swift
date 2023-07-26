//
//  FineRepositoryImpl.swift
//  FineDataImpl
//
//  Created by 최혜린 on 2023/07/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import FineData
import MOITNetwork

import RxSwift

final class FineRepositoryImpl: FineRepository {
	
	let network: Network
	
	init(
		network: Network
	) {
		self.network = network
	}
	
	func fetchFineInfo(moitID: String) -> Single<FineInfo> {
		let endPoint = FineEndpoint.fetchFineInfo(moitId: moitID)
		
		return network.request(with: endPoint)
	}
}
