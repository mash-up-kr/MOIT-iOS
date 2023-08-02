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
	
	public func fetchFineInfo(moitID: Int) -> Single<FineInfo> {
		let endPoint = FineEndpoint.fetchFineInfo(moitId: moitID)
		
		return network.request(with: endPoint)
	}
	
	public func fetchFineItem(moitID: Int, fineID: Int) -> Single<FineItem> {
		let endPoint = FineEndpoint.fetchFineItem(moitID: moitID, fineID: fineID)
		
		return network.request(with: endPoint)
	}
	
	public func postFineEvaluate(moitID: Int, fineID: Int, data: Data?) -> Single<Bool> {
		let multipartEndpoint = FineEndpoint.postFineEvaluate(moitID: moitID, fineID: fineID, data: data)
		
		if let endpoint = multipartEndpoint {
			return network.request(with: endpoint)
		} else {
			return .just(false)
		}
	}
	
	public func postAuthorizeFine(moitID: Int, fineID: Int, isConfirm: Bool) -> Single<Bool> {
		let endpoint = FineEndpoint.postAuthorizeFine(
			moitID: moitID,
			fineID: fineID,
			isConfirm: isConfirm
		)
		
		return network.request(with: endpoint)
	}
}
