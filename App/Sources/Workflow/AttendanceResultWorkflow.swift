//
//  AttendanceResultWorkflow.swift
//  App
//
//  Created by 송서영 on 2023/08/07.
//

import Foundation
import RIBs
import MOITWeb
import MOITListUserInterface
import RxSwift

final class AttendanceResultWorkflow: Workflow<RootActionableItem> {
    private let id: String
    
    public init(id: String) {
        self.id = id
        super.init()
        
        self.commit()
    }
    
    private func commit() {
        self.onStep { rootItem -> Observable<(RootActionableItem, ())> in
            rootItem.waitForLogin()
        }
        .onStep({ rootItem, _ -> Observable<(MOITListActionableItem, ())> in
            rootItem.routeToMOITList()
        })
        .onStep({ [weak self] listActionableItem, _ -> Observable<(MOITWebActionableItem, ())> in
            guard let self else { return .empty() }
            return listActionableItem.routeToAttendanceResult(id: self.id)
        })
        .commit()
    }
}
