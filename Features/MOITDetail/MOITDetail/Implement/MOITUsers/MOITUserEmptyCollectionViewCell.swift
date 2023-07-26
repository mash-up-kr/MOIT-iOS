//
//  MOITUserEmptyCollectionViewCell.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout
import ResourceKit

final class MOITUserEmptyCollectionViewCell: UICollectionViewCell {

    private let flexRootView = UIView()
    private let label: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.p3
        label.textColor = ResourceKitAsset.Color.gray600.color
        label.text = "참여한 스터디원이 없어요"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(flexRootView)
        flexRootView.backgroundColor = .white
        define()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
    }
    
    private func define() {
        flexRootView.flex
            .justifyContent(.center)
            .alignItems(.center)
            .addItem(label)
    }
}
