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

public final class NavigationItem: UIButton {
    
    public let type: NavigationItemType
    
    public init(type: NavigationItemType) {
        self.type = type
        super.init(frame: .zero)
        configureIcon(icon: type.icon)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureIcon(icon: UIImage?) {
        guard let tintedImage = type.icon?.withRenderingMode(.alwaysTemplate),
              self.type != .logo
        else {
            self.setImage(type.icon, for: .normal)
            return 
        }
        
        self.setImage(tintedImage, for: .normal)
    }
}
