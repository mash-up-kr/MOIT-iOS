//
//  NavigationColorType.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

public enum NavigationColorType {
    case normal
    case reverse
    
    var tintColor: UIColor {
        switch self {
        case .normal:
            return ResourceKitAsset.Color.gray900.color
        case .reverse:
            return ResourceKitAsset.Color.white.color
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .normal:
            return .clear
        case .reverse:
            return ResourceKitAsset.Color.gray500.color
        }
    }
}
