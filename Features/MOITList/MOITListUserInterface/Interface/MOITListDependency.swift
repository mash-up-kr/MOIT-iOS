//
//  MOITListDependency.swift
//  MOITListUserInterface
//
//  Created by kimchansoo on 2023/07/15.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITNetwork
import MOITListDomain

public protocol MOITListDependency: Dependency {
    var network: Network { get }
    var fetchMOITListsUseCase: FetchMoitListUseCase { get }
    var calculateLeftTimeUseCase: CalculateLeftTimeUseCase { get }
    var fetchPaneltyToBePaiedUseCase: FetchBannersUseCase { get }
}
