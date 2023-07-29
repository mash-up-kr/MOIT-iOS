//
//  MOITSettingDividerCollectionViewCell.swift
//  MOITSettingImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit
import ResourceKit

final class MOITSettingDividerCollectionViewCell: UICollectionViewCell {
    private let flexRootView = UIView()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = ResourceKitAsset.Color.gray100.color
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        define()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        define()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flexRootView.pin.all()
        flexRootView.flex.layout()
    }
    
    private func configure() {
        self.flexRootView.backgroundColor = .white
    }
    
    private func define() {
        self.addSubview(flexRootView)
        flexRootView.flex.addItem(dividerView)
            .height(1)
            .marginHorizontal(20)
    }
}
