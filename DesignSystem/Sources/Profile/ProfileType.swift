//
//  ProfileType.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/13.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public enum ProfileType {
    case large
    case medium
    case small
    
    var radius: CGFloat {
        switch self {
        case .large:
            return 38
        case .medium:
            return 28
        case .small:
            return 18
        }
    }
    
    var size: CGFloat {
        switch self {
        case .large:
            return 90
        case .medium:
            return 60
        case .small:
            return 40
        }
    
    }
}
