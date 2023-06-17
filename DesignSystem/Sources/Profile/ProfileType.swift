//
//  ProfileType.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/13.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

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

public enum ProfileImageType: Int {
    case one = 0
    case two, three, four, five, six, seven, eight, nine, ten
    // TODO: - 프로필 이미지 시안 나오면 변경
    var image: UIImage {
        switch self {
        case .one:
            return ResourceKitAsset.Icon.apple.image
        case .two:
            return ResourceKitAsset.Icon.apple.image
        case .three:
            return ResourceKitAsset.Icon.apple.image
        case .four:
            return ResourceKitAsset.Icon.apple.image
        case .five:
            return ResourceKitAsset.Icon.apple.image
        case .six:
            return ResourceKitAsset.Icon.apple.image
        case .seven:
            return ResourceKitAsset.Icon.apple.image
        case .eight:
            return ResourceKitAsset.Icon.apple.image
        case .nine:
            return ResourceKitAsset.Icon.apple.image
        case .ten:
            return ResourceKitAsset.Icon.apple.image
        }
    }
}
