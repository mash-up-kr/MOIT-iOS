//
//  MOITChipType.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/06/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

public enum MOITChipType {
	case attend
	case late
	case absent
	case dueDate(date: Int)
	case finish
	
	var cornerRadius: CGFloat {
		switch self {
		case .attend, .late, .absent:
			return 15
		case .dueDate, .finish:
			return 9
		}
	}
	
	var title: String {
		switch self {
		case .attend:
			return "출석"
		case .late:
			return "지각"
		case .absent:
			return "결석"
		case .dueDate(let date):
			return "D-\(date)"
		case .finish:
			return "종료"
		}
	}
	
	var backgroundColor: UIColor {
		switch self {
		case .attend:
			return ResourceKitAsset.Color.blue800.color
		case .late:
			return ResourceKitAsset.Color.orange200.color
		case .absent:
			return ResourceKitAsset.Color.orange100.color
		case .dueDate, .finish:
			return ResourceKitAsset.Color.gray200.color
		}
	}
	
	var textColor: UIColor {
		switch self {
		case .attend, .absent, .late:
			return ResourceKitAsset.Color.white.color
		case .dueDate, .finish:
			return ResourceKitAsset.Color.gray900.color
		}
	}
	
	var height: CGFloat {
		switch self {
		case .attend, .late, .absent:
			return 30
		case .dueDate, .finish:
			return 18
		}
	}
	
	var marginHorizontal: CGFloat {
		switch self {
		case .attend, .late, .absent:
			return 12
		case .dueDate, .finish:
			return 10
		}
	}
	
	var font: UIFont {
		switch self {
		case .attend, .late, .absent:
			return ResourceKitFontFamily.p3
		case .dueDate, .finish:
			return ResourceKitFontFamily.caption
		}
	}
}
