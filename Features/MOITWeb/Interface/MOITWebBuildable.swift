//
//  MOITWebBuildable.swift
//  MOITWeb
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation
import RIBs

public protocol MOITWebBuildable: Buildable {
    func build(
        withListener listener: MOITWebListener,
        path: MOITWebPath
    ) -> ViewableRouting
}
