//
//  MOITListDependency.swift
//  MOITListUserInterface
//
//  Created by kimchansoo on 2023/07/15.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import MOITListDomain

public protocol MOITListDependency: Dependency {
    
    var fetchMOITListsUseCase: FetchMoitListUseCase { get }
    var fetchLeftTimeUseCase: FetchLeftTimeUseCase { get }
    var fetchPaneltyToBePaiedUSeCase: FetchPenaltyToBePaidUseCase { get }
}
