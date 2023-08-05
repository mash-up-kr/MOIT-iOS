//
//  MOITSettingToggleCollectionViewCell.swift
//  MOITSettingImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit
import ResourceKit
import DesignSystem
import RxSwift

struct MOITSettingToggleItem {
    let title: String
    let description: String
    var isToggled: Bool
}

final class MOITSettingToggleCollectionViewCell: UICollectionViewCell {
    private let flexRootView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.h6
        label.textColor = ResourceKitAsset.Color.gray900.color
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.p3
        label.textColor = ResourceKitAsset.Color.gray500.color
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    fileprivate let toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.tintColor = ResourceKitAsset.Color.blue800.color
        toggle.onTintColor = ResourceKitAsset.Color.blue800.color
        toggle.isUserInteractionEnabled = false
        return toggle
    }()
    
    private(set) var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        define()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flexRootView.pin.all()
        flexRootView.flex.layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = .init()
    }
    
    private func define() {
        self.addSubview(flexRootView)
        flexRootView.flex
            .direction(.row)
            .alignItems(.center)
            .paddingHorizontal(20)
            .define { flex in
                flex.addItem()
                    .define { flex in
                        flex.addItem(titleLabel)
                        flex.addItem(descriptionLabel)
                            .marginTop(10)
                    }
                    .shrink(1)
                flex.addItem(toggle)
            }
    }
    
    func configure(_ item: MOITSettingToggleItem) {
        self.titleLabel.text = item.title
        self.descriptionLabel.text = item.description
        self.toggle.isOn = item.isToggled
        
        descriptionLabel.flex.markDirty()
        titleLabel.flex.markDirty()
        toggle.flex.markDirty()
        self.setNeedsLayout()
    }
}

extension Reactive where Base: MOITSettingToggleCollectionViewCell {
    var didToggle: Observable<Bool> {
        base.toggle.rx.tapGesture()
            .when(.recognized)
            .map { _ in return base.toggle.isOn }
            .asObservable()
    }
}
