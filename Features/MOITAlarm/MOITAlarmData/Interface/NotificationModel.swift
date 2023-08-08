//
//  NotificationModel.swift
//  MOITAlarmData
//
//  Created by 최혜린 on 2023/08/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

// MARK: - NotificationModel
public struct NotificationModel: Codable {
	public let userID: Int
	public let notificationItems: [NotificationItem]

	enum CodingKeys: String, CodingKey {
		case userID = "userId"
		case notificationItems = "notificationList"
	}
}

// MARK: - NotificationList
public struct NotificationItem: Codable {
	public let id, userID: Int
	public let type, title, body, urlScheme: String
	public let notificationAt: String

	enum CodingKeys: String, CodingKey {
		case id
		case userID = "userId"
		case type, title, body, urlScheme, notificationAt
	}
}
