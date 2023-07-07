//
//  MOITDetailDependency.swift
//  MOITDetail
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITNetwork
import RIBs

public protocol MOITDetailDependency: Dependency {
    var tabTypes: [MOITDetailTab] { get }
    var network: Network { get }
}
