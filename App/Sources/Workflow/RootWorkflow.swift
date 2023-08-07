//
//  RootWorkflow.swift
//  App
//
//  Created by 송서영 on 2023/08/06.
//

import RIBs
import RxSwift
import Foundation
import MOITListUserInterface

public class RootWorkflow: Workflow<RootActionableItem> {
    
    public override init() {
        super.init()

        self
            .onStep { rootActionableItem -> Observable<(RootActionableItem, ())> in
                rootActionableItem.waitForLogin()
            }
            .onStep { rootActionableItem, _ -> Observable<(MOITListActionableItem, ())> in
                rootActionableItem.routeToMOITList()
            }
            .commit()
    }
    
    deinit { debugPrint("\(self) deinit") }
}
