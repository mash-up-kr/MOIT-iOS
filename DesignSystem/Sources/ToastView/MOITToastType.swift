//
//  MOITToastType.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/07/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

public enum MOITToastType {
	case success
	case fail
	
	var image: UIImage {
		switch self {
			case .success:
				return ResourceKitAsset.Icon.success.image
			case .fail:
				return ResourceKitAsset.Icon.error.image
		}
	}
}
