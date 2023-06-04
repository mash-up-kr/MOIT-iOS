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
//    let titleText: String?
    public let rightItems: [NavigationItem]
    
    // MARK: - Initializers
    /// leftItems와 rightItems에 좌우측에 들어갈 item을 정의합니다.
    /// MOITNavigationBar.leftItems[n].rx.tap으로 이벤트를 받아올 수 있습니다.
    public init(
        leftItems: [NavigationItemType],
        title: String?,
        rightItems: [NavigationItemType],
        backgroundColor: UIColor,
        tintColor: UIColor
    ) {
        self.leftItems = leftItems.map { NavigationItem(type: $0)}
        self.rightItems = rightItems.map { NavigationItem(type: $0)}
        
        super.init(frame: .zero)
        
        self.configureLeftItems(self.leftItems)
        self.configureTitle(title)
        self.configureRightItems(self.rightItems)
        self.configureLayout()
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
        
        self.flexRootView.backgroundColor = .systemPink
    }
    
    // MARK: - Methods
}

// MARK: - Private Functions

extension MOITNavigationBar {
    
    private func configureFlexRootView() {
//        self.flexRootView.backgroundColor = _backgroundColor
        self.flexRootView.clipsToBounds = true
    }
    
    private func configureLeftItems(_ leftItems: [NavigationItem]) {
        
    }
    
    private func configureTitle(_ title: String?) {
        self.titleLabel.text = title
    }
    
    private func configureRightItems(_ rightItems: [NavigationItem]) {
        
    }
//
//    private func configureLayout() {
//        self.addSubview(flexRootView)
//
//        self.flexRootView.flex
//            .height(56)
//            .width(100%)
//            .direction(.row)
//            .justifyContent(.spaceBetween)
//            .alignItems(.center)
//            .define { flex in
//                flex.addItem()
//                    .direction(.row)
//                    .define { flex in
//                        self.leftItems.forEach { flex.addItem($0).size(24)}
//                    }
//                    .marginLeft(16)
//                // 여백 생성 코드
//
//
//                flex.addItem(self.titleLabel).grow(1)
//                flex.addItem()
//                    .direction(.row)
//                    .define { flex in
//                        self.rightItems.forEach { flex.addItem($0).size(24).marginLeft(20)}
//                    }
//                    .marginRight(16)
//            }
//    }
    private func configureLayout() {
        self.addSubview(flexRootView)

        self.flexRootView.flex
            .height(56)
//            .width(100%)
            .direction(.row)
            .alignItems(.center)
            .define { flex in
                flex.addItem()
                    .direction(.row)
                    .grow(1)
                    .justifyContent(.start)
                    .define { flex in
                        self.leftItems.forEach { flex.addItem($0).size(24)}
                    }
                    .marginLeft(16)
                
                flex.addItem(self.titleLabel)

//                    .alignSelf(.center)
                    
                flex.addItem()
                    .direction(.row)
                    .grow(1)
                    .justifyContent(.end)
                    .define { flex in
                        self.rightItems.forEach { flex.addItem($0).size(24).marginLeft(20)}
                    }
                    .marginRight(16)
            }
    }

}
