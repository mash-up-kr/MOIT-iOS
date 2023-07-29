//
//  MOITDetailInfoView.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import MOITDetail
import DesignSystem
import ResourceKit

import FlexLayout
import PinLayout
import SkeletonView

final class MOITDetailInfoView: UIView {
      
    private let flexRootView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.p3
        label.textColor = ResourceKitAsset.Color.gray800.color
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.p3
        label.textColor = ResourceKitAsset.Color.gray600.color
        label.numberOfLines = 0
        return label
    }()
    
    init(viewModel: MOITDetailInfoViewModel) {
        super.init(frame: .zero)
        self.confifugre(viewModel: viewModel)
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
    }
    
    private func configureLayouts() {
        self.addSubview(self.flexRootView)

        self.flexRootView.flex
            .direction(.row)
            .alignItems(.start)
            .define { flex in
                flex.addItem(self.titleLabel)
                
                flex.addItem(self.descriptionLabel)
                    .marginLeft(12)
            }
    }
    
    func confifugre(viewModel: MOITDetailInfoViewModel) {
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.titleLabel.flex.markDirty()
        self.descriptionLabel.flex.markDirty()
        self.setNeedsLayout() 
    }
}
