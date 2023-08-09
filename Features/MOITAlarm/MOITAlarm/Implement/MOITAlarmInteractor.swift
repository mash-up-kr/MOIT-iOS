//
//  MOITAlarmInteractor.swift
//  MOITAlarmImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITAlarm
import MOITAlarmDomain
import Foundation
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

final class MOITAlarmInteractor: PresentableInteractor<MOITAlarmPresentable>,
                                 MOITAlarmInteractable,
                                 MOITAlarmPresentableListener {
    
    weak var router: MOITAlarmRouting?
    weak var listener: MOITAlarmListener?
    private var entities: NotificationEntities = []
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
            .asObservable()
            .do(onNext: { [weak self] entities in
                self?.entities = entities
            })
        
            .compactMap { [weak self] entities -> [MOITAlarmCollectionViewCellItem]? in
                    return self?.convertToMOITAlarmViewModel(entities: entities)
                    
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] collectionViewCellItems in
                self?.presenter.configure(collectionViewCellItems)
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    func didSwipeBack() {
        listener?.didSwipeBackAlarm()
    }
    
    func didTapBack() {
        listener?.didTapBackAlarm()
    }
    
    func didTapItem(at index: Int) {
        guard let entity = self.entities[safe: index] else { return }
        UserDefaults.standard.set(true, forKey: entity.id)
        self.listener?.didTapAlarm(scheme: entity.urlScheme)
    }
    
    private func convertToMOITAlarmViewModel(entities: NotificationEntities) -> [MOITAlarmCollectionViewCellItem] {
        entities.map { entity in
            let isRead = (UserDefaults.standard.value(forKey: entity.id) as? Bool) ?? false
            return MOITAlarmCollectionViewCellItem(
                isRead: isRead,
                title: entity.title,
                description: entity.body,
                urlScheme: entity.urlScheme
            )
        }
    }
}
