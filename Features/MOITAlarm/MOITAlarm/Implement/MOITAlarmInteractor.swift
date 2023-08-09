//
//  MOITAlarmInteractor.swift
//  MOITAlarmImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITAlarm
import MOITAlarmDomain

import RIBs
import RxSwift

protocol MOITAlarmRouting: ViewableRouting {
    
}

protocol MOITAlarmPresentable: Presentable {
    var listener: MOITAlarmPresentableListener? { get set }
	
	func configure(_ collectionViewCellItems: [MOITAlarmCollectionViewCellItem])
}

protocol MOITAlarmInteractorDependency {
	var fetchNotificationUseCase: FetchNotificationListUseCase { get }
}

final class MOITAlarmInteractor: PresentableInteractor<MOITAlarmPresentable>, MOITAlarmInteractable, MOITAlarmPresentableListener {

    weak var router: MOITAlarmRouting?
    weak var listener: MOITAlarmListener?
	
	private let dependency: MOITAlarmInteractorDependency

    init(
		presenter: MOITAlarmPresentable,
		dependency: MOITAlarmInteractorDependency
	) {
		self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
	
	func viewDidLoad() {
		dependency.fetchNotificationUseCase.execute()
			.observe(on: MainScheduler.instance)
			.compactMap { [weak self] entity -> [MOITAlarmCollectionViewCellItem]? in
				return self?.convertToMOITAlarmViewModel(entity: entity)
			}
			.subscribe(
				onSuccess: { [weak self] collectionViewCellItems in
					self?.presenter.configure(collectionViewCellItems)
				}
			)
			.disposeOnDeactivate(interactor: self)
	}
	
	func didSwipeBack() {
		listener?.didSwipeBackAlarm()
	}
    
    func didTapBack() {
        listener?.didTapBackAlarm()
    }
	
	private func convertToMOITAlarmViewModel(entity: NotificationEntity) -> [MOITAlarmCollectionViewCellItem] {
		entity.map { item in
			MOITAlarmCollectionViewCellItem(
				isRead: true,
				title: item.title,
				description: item.body,
				urlScheme: item.urlScheme
			)
		}
	}
}
