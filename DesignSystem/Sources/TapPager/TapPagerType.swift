//
//  TapPagerType.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/07.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

public enum PagerType {
    case underline
    case segment
    
    var enableColor: UIColor {
        switch self {
        case .underline:
            return ResourceKitAsset.Color.gray800.color
        case .segment:
            return ResourceKitAsset.Color.gray800.color
        }
    }
    
    var disableColor: UIColor {
        switch self {
        case .underline:
            return ResourceKitAsset.Color.gray500.color
        case .segment:
            return ResourceKitAsset.Color.gray600.color
        }
    }
    
    var font: UIFont {
        switch self {
        case .underline:
            return ResourceKitFontFamily.h4
        case .segment:
            return ResourceKitFontFamily.p2
        }
    }
}
