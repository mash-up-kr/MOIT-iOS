//
//  MOITNavigationBar.swift
//  DesignSystem
//
//  Created by kimchansoo on 2023/06/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import FlexLayout
import PinLayout
import RxSwift


public final class MOITNavigationBar: UIView {
    
    // MARK: - UI
    private let flexRootView = UIView()

    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = ResourceKitAsset.Color.gray900.color
        label.textAlignment = .center
        label.font = ResourceKitFontFamily.h6
        return label
    }()

    
    // MARK: - Properties
    public let leftItems: [NavigationItem]
    public let rightItems: [NavigationItem]
    
    private let colorType: NavigationColorType
    
    // MARK: - Initializers
    /// leftItems와 rightItems에 좌우측에 들어갈 item을 정의합니다.
    /// MOITNavigationBar.leftItems[n].rx.tap으로 이벤트를 받아올 수 있습니다.
    public init(
        leftItems: [NavigationItemType],
        title: String?,
        rightItems: [NavigationItemType],
        colorType: NavigationColorType = .normal
    ) {
        self.leftItems = leftItems.map { NavigationItem(type: $0)}
        self.rightItems = rightItems.map { NavigationItem(type: $0)}
        self.colorType = colorType
        
        super.init(frame: .zero)
        
        self.configureTitle(title)
        self.configureLayout()
        self.configureColor()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("can not init from coder")
    }

    // MARK: - Lifecycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        self.flexRootView.pin.all()
        self.flexRootView.flex.layout(mode: .fitContainer)
    }
    
    // MARK: - Methods
}

// MARK: - Private Functions

extension MOITNavigationBar {
        
    private func configureTitle(_ title: String?) {
        self.titleLabel.text = title
    }

    private func configureLayout() {
        self.addSubview(flexRootView)

        self.flexRootView.flex
            .height(56)
            .direction(.row)
            .alignItems(.center)
            .justifyContent(.spaceBetween)
            .padding(16)
            .backgroundColor(colorType.backgroundColor)
            .define { flex in
                flex.addItem()
                    .direction(.row)
                    .justifyContent(.start)
                    .define { flex in
                        self.leftItems.forEach { flex.addItem($0).size(24)}
                    }
                
                flex.addItem()
                    .direction(.row)
                    .position(.absolute)
                    .width(100%)
                    .justifyContent(.center)
                    .define { flex in
                        flex.addItem(self.titleLabel)
                    }
                
                flex.addItem()
                    .direction(.row)
                    .justifyContent(.end)
                    .define { flex in
                        self.rightItems.forEach { flex.addItem($0).size(24).marginLeft(20)}
                    }
            }
    }
    
    private func configureColor() {
        leftItems.forEach { $0.tintColor = self.colorType.tintColor}
        rightItems.forEach { $0.tintColor = self.colorType.tintColor}
        titleLabel.textColor = colorType.tintColor
        
        leftItems.forEach { $0.backgroundColor = self.colorType.backgroundColor}
        rightItems.forEach { $0.backgroundColor = self.colorType.backgroundColor}
        titleLabel.backgroundColor = colorType.backgroundColor
        
        self.backgroundColor = colorType.backgroundColor
    }

}