//
//  MOITListBuildable.swift
//  MOITListUserInterface
//
//  Created by kimchansoo on 2023/07/15.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

public protocol MOITListBuildable: Buildable {
    func build(withListener listener: MOITListListener) -> ViewableRouting
}
