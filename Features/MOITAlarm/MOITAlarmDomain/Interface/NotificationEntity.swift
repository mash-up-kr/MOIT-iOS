//
//  NotificationEntity.swift
//  MOITAlarmDomain
//
//  Created by 최혜린 on 2023/08/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public typealias NotificationEntity = [NotificationItem]

public struct NotificationItem {
	public let title: String
	public let body: String
	public let urlScheme: String

	public init(
		title: String,
		body: String,
		urlScheme: String
	) {
		self.title = title
		self.body = body
		self.urlScheme = urlScheme
	}
}
