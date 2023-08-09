//
//  NotificationEntity.swift
//  MOITAlarmDomain
//
//  Created by 최혜린 on 2023/08/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public typealias NotificationEntities = [NotificationItem]

public struct NotificationItem {
	public let title: String
	public let body: String
	public let urlScheme: String
    public let id: String

	public init(
        id: String,
		title: String,
		body: String,
		urlScheme: String
	) {
        self.id = id
		self.title = title
		self.body = body
		self.urlScheme = urlScheme
	}
}
