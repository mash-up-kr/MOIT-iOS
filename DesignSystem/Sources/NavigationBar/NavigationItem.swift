//
//  MOITNavigationItem.swift
//  DesignSystem
//
//  Created by kimchansoo on 2023/06/04.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import RxSwift
import RxGesture

public final class NavigationItem: UIButton {
    
    public init(type: NavigationItemType) {
        super.init(frame: .zero)
        self.setImage(type.icon, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
