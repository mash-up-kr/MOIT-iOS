//
//  MOITAlarmRepositoryImpl.swift
//  MOITAlarmDataImpl
//
//  Created by 최혜린 on 2023/08/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITAlarmData
import MOITNetwork

import RxSwift

public final class MOITAlarmRepositoryImpl: MOITAlarmRepository {
	
	private let network: Network
	
	public init(network: Network) {
		self.network = network
	}
	
	public func fetchNotificationList() -> Single<NotificationModel> {
		let endpoint = MOITAlarmEndpoint.fetchNotificationList()
		return network.request(with: endpoint)
	}
}
