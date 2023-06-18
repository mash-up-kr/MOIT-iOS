//
//  MOITDetailInfoView.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout
import DesignSystem
import ResourceKit
import SkeletonView

struct MOITDetailInfoViewModel {
    let title: String
    let description: String
}

final class MOITDetailInfoView: UIView {
      
    private let flexRootView: UIView = {
        let view = UIView()
//        view.isSkeletonable = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.p3
        label.textColor = ResourceKitAsset.Color.gray800.color
        label.isSkeletonable = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.p3
        label.textColor = ResourceKitAsset.Color.gray600.color
        label.numberOfLines = 0
        label.isSkeletonable = true
        return label
    }()
    
    init(viewModel: MOITDetailInfoViewModel) {
        super.init(frame: .zero)
        self.confifugre(viewModel: viewModel)
        self.configureLayouts()
        self.flexRootView.showAnimatedGradientSkeleton()
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
//        self.isSkeletonable = true
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
        self.hideSkeleton()
        
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.titleLabel.flex.markDirty()
        self.descriptionLabel.flex.markDirty()
        self.setNeedsLayout()
        
    }
}
