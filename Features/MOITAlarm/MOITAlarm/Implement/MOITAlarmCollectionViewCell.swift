//
//  MOITAlarmCollectionViewCell.swift
//  MOITAlarmImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit
import ResourceKit

struct MOITAlarmCollectionViewCellItem {
    let isRead: Bool
    let title: String
    let description: String
	let urlScheme: String
}
final class MOITAlarmCollectionViewCell: UICollectionViewCell {
    
    private let flexRootView = UIView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.p2
        label.textColor = ResourceKitAsset.Color.gray800.color
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.p1
        label.textColor = ResourceKitAsset.Color.gray900.color
        label.numberOfLines = 0
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
        flexRootView.pin.all()
        flexRootView.flex.layout()
    }
    
    func configure(item: MOITAlarmCollectionViewCellItem) {
        self.titleLabel.text = item.title
        self.descriptionLabel.text = item.description
        if item.isRead {
            flexRootView.backgroundColor = .white
        } else {
            flexRootView.backgroundColor = ResourceKitAsset.Color.blue100.color
        }
        self.titleLabel.flex.markDirty()
        self.descriptionLabel.flex.markDirty()
        self.setNeedsLayout()
    }
}

// MARK: - Private functions
private extension MOITAlarmCollectionViewCell {
    
    func define() {
        self.addSubview(flexRootView)
        flexRootView.flex
            .padding(20)
            .define { flex in
			flex.addItem(titleLabel)
            flex.addItem(descriptionLabel)
                .marginTop(10)
        }
    }
}
