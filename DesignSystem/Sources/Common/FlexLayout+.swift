//
//  Flex+.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/12.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import FlexLayout

public extension FlexLayout.Flex {
    
    @discardableResult
    func addOptionalItem(_ view: UIView?) -> Flex {
        if let view {
            self.addItem(view)
        }
        
        return self
    }
}
