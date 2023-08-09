//
//  fetchNotificationListUseCase.swift
//  MOITAlarmDomain
//
//  Created by 최혜린 on 2023/08/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

public protocol FetchNotificationListUseCase {
	func execute() -> Single<NotificationEntities>
}
