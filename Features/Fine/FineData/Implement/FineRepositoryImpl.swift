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

public final class FineRepositoryImpl: FineRepository {
	
	private let network: Network
	
	public init(
		network: Network
	) {
		self.network = network
	}
	
	public func fetchFineInfo(moitID: String) -> Single<FineInfo> {
		let endPoint = FineEndpoint.fetchFineInfo(moitId: moitID)
		
		return network.request(with: endPoint)
	}
}