//
//  FineWorkflow.swift
//  App
//
//  Created by 송서영 on 2023/08/07.
//

import Foundation
import RIBs
import RxSwift
import MOITListUserInterface
import MOITDetail
import FineUserInterface

final class FineWorkflow: Workflow<RootActionableItem> {
    private let moitID: String
    private let fineID: String
    
    public init(moitID: String, fineID: String) {
        self.moitID = moitID
        self.fineID = fineID
        
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
        .onStep({ [weak self] listActionableItem, _ -> Observable<(MOITDetailActionableItem, ())> in
            guard let self else { return .empty() }
            return listActionableItem.routeToDetail(id: self.moitID)
        })
        .onStep { [weak self] detailActionableItem, _ -> Observable<(FineActionableItem, ())> in
            return detailActionableItem.routeToFine()
        }
        .onStep({ [weak self] fineActionableItem, _ -> Observable<(AuthorizePaymentActionableItem, ())> in
            guard let self else { return .empty() }
            return fineActionableItem.routeToAuthorizePayment(
                moitID: self.moitID,
                fineID: self.fineID
            )
        })
        .commit()
    }
}
