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
    
    public init(id: String) {
        super.init()

        self.onStep { rootItem -> Observable<(RootActionableItem, ())> in
            rootItem.waitForLogin()
        }
//        .onStep({ rootActionableItem, _ -> Observable<(RootActionableItem, ())> in
//            <#code#>
//        })
//        .onStep { rootActionableItem, _ -> Observable<(MOITDetailActionableItem, ())> in
//            listActionableItem.routeToDetail(id: id)
//        }
        .commit()
    }
    
    deinit { debugPrint("\(self) deinit") }
}
