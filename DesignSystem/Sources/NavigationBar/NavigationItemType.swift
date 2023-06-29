//
//  NavigationItemType.swift
//  DesignSystem
//
//  Created by kimchansoo on 2023/06/04.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

public enum NavigationItemType {
    case logo
    case close
    case back
    case share
    case setting
    case alarm
    
    var icon: UIImage? {
        switch self {
        case .logo:
            return ResourceKitAsset.Icon.logo.image
        case .close:
            return ResourceKitAsset.Icon.x.image
        case .back:
            return ResourceKitAsset.Icon.arrowLeft.image
        case .share:
            return ResourceKitAsset.Icon.share.image
        case .setting:
            return ResourceKitAsset.Icon.settings.image
        case .alarm:
            return ResourceKitAsset.Icon.bell.image
        }
    }
}
