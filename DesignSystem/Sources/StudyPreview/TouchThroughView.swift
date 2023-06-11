//
//  TouchThroughView.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/09.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

class TouchThroughView: UIView {
    var button: UIButton? = nil
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let button = self.button {
            return self.bounds.contains(point) || button.frame.contains(point)
        } else {
            return super.point(inside: point, with: event)
        }
    }
}
