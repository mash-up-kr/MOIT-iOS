//
//  InputParticipateCodeBuildable.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/07/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

public protocol InputParticipateCodeBuildable: Buildable {
	func build(withListener listener: InputParticipateCodeListener) -> ViewableRouting
}
