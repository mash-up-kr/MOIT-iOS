//
//  MOITDetailWorkflow.swift
//  App
//
//  Created by 송서영 on 2023/08/06.
//

import Foundation
import RIBs
import RxSwift
import Foundation
import MOITListUserInterface
import MOITDetail

public class MOITDetailWorkflow: Workflow<RootActionableItem> {
    
    private let id: String
    
    public init(id: String) {
        self.id = id
        super.init()
        commit()
    }
    
    private func commit() {
        self.onStep { rootItem -> Observable<(RootActionableItem, ())> in
            rootItem.waitForLogin()
        }
        .onStep({ rootItem, _ -> Observable<(MOITListActionableItem, ())> in
            rootItem.routeToMOITList()
        })
        .onStep({ [weak self] listActionableItem, _ -> Observable<(MOITDetailActionableItem, ())> in
            guard let self else { return .empty() }
            return listActionableItem.routeToDetail(id: self.id)
        })
        .commit()
    }
    
    deinit { debugPrint("\(self) deinit") }
}
