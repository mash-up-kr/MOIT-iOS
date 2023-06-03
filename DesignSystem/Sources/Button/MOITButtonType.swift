//
//  MOITButtonType.swift
//  DesignSystem
//
//  Created by 송서영 on 2023/06/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit
import ResourceKit

public enum MOITButtonType {
    case mini
    case small
    case medium
    case large
    
    var marginVertical: CGFloat {
        switch self {
        case .mini: return 4
        case .small: return 16.5
        case .medium: return 13
        case .large: return 14
        }
    }
    var width: CGFloat {
        switch self {
        case .mini: return 101
        case .small: return 163
        case .medium: return 303
        case .large: return 335
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .mini, .medium: return 10
        default: return 20
        }
    }
    
    var font: UIFont {
        switch self {
        case .mini: return ResourceKitFontFamily.p2
        default: return ResourceKitFontFamily.h6
        }
    }
}
