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
    case zero = 0
    case one, two, three, four, five, six, seven
    // TODO: - 프로필 이미지 시안 나오면 변경
    var image: UIImage {
        switch self {
        case .zero:
            return ResourceKitAsset.Icon.profile0.image
        case .one:
            return ResourceKitAsset.Icon.profile1.image
        case .two:
            return ResourceKitAsset.Icon.profile2.image
        case .three:
            return ResourceKitAsset.Icon.profile3.image
        case .four:
            return ResourceKitAsset.Icon.profile4.image
        case .five:
            return ResourceKitAsset.Icon.profile5.image
        case .six:
            return ResourceKitAsset.Icon.profile6.image
        case .seven:
            return ResourceKitAsset.Icon.profile7.image
        }
    }
}
