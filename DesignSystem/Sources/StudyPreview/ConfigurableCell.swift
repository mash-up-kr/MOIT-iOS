//
//  ConfigurableCell.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/08.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol ConfigurableCell {
    associatedtype DataType: Hashable
    func configure(with data: DataType)
}
