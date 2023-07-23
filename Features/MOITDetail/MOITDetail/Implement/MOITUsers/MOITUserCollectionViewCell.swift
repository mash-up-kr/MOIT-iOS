//
//  MOITUserCollectionViewCell.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem
import FlexLayout
import PinLayout

final class MOITUserCollectionViewCell: UICollectionViewCell {
    private let flexRootview = UIView()
    private var userView = MOITList(type: .people, imageUrlString: "",title: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flexRootview.pin.all()
        self.flexRootview.flex.layout()
    }
    
    private func configureView() {
        self.contentView.addSubview(flexRootview)
        self.flexRootview.flex.addItem(userView)
    }
    
    func configureUser(profileImage: String, name: String) {
        userView.configure(
            title: name,
            detail: nil
        )
        self.userView.flex.markDirty()
        self.setNeedsLayout()
    }
}
