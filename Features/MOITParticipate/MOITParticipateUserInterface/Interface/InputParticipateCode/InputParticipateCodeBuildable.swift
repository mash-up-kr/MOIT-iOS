//
//  InputParticipateCodeBuildable.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/20.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

public protocol InputParticipateCodeBuildable: Buildable {
	func build(withListener listener: InputParticipateCodeListener) -> ViewableRouting
}
