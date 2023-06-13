//
//  MOITListType.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/06/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public enum MOITListType {
	case allAttend
	case myAttend
	case sendMoney
	case myMoney
	case people
	
	var height: CGFloat {
		switch self {
		case .people:
			return 40
		default:
			return 41
		}
	}
}
