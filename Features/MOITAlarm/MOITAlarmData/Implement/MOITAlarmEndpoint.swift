//
//  MOITAlarmEndpoint.swift
//  MOITAlarmDataImpl
//
//  Created by 최혜린 on 2023/08/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITAlarmData
import MOITNetwork

enum MOITAlarmEndpoint {
	static func fetchNotificationList() -> Endpoint<NotificationModel> {
		Endpoint(
			path: "/api/v1/notification",
			method: .get
		)
	}
}
