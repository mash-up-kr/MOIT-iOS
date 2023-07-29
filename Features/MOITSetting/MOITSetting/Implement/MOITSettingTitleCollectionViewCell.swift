//
//  MOITSettingTitleCollectionViewCell.swift
//  MOITSettingImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit
import PinLayout
import FlexLayout
import ResourceKit

final class MOITSettingTitleCollectionViewCell: UICollectionViewCell {
    private let flexRootview = UIView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.h6
        label.textColor = ResourceKitAsset.Color.gray900.color
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        define()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        define()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flexRootview.pin.all()
        flexRootview.flex.layout()
    }
    
    private func define() {
        self.addSubview(flexRootview)
        flexRootview.flex
            .padding(20)
            .define { flex in
            flex.addItem(titleLabel)
        }
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
}
