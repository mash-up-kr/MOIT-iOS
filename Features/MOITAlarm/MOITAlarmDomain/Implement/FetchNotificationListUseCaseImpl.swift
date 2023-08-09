//
//  FetchNotificationListUseCaseImpl.swift
//  MOITAlarmDomainImpl
//
//  Created by 최혜린 on 2023/08/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITAlarmDomain
import MOITAlarmData

import RxSwift

public class FetchNotificationListUseCaseImpl: FetchNotificationListUseCase {
	
	private let repository: MOITAlarmRepository
	
	public init(repository: MOITAlarmRepository) {
		self.repository = repository
	}
	
	public func execute() -> Single<NotificationEntities> {
		return repository.fetchNotificationList()
			.compactMap({ notiModel -> NotificationEntities? in
				let notificationEntityList = notiModel.notificationItems.map {
					NotificationItem(
                        id: "\($0.id)",
                        title: $0.title,
						body: $0.body,
						urlScheme: $0.urlScheme
					)
				}

				return notificationEntityList
			})
			.asObservable().asSingle()
	}
}
