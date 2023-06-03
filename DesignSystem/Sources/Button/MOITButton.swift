//
//  MOITButton.swift
//  DesignSystem
//
//  Created by 송서영 on 2023/06/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import PinLayout
import FlexLayout
import ResourceKit

public enum MOITButtonType {
    case mini
    case small
    case medium
    case large
    
    fileprivate var marginVertical: CGFloat {
        switch self {
        case .mini: return 4
        case .small: return 16.5
        case .medium: return 13
        case .large: return 14
        }
    }
    
//    fileprivate var marginHorizontal: CGFloat {
//        switch self {
//        case .mini: return 4
//        case .small: return 16.5
//        case .medium: return 13
//        case .large: return 14
//        }
//    }
    
    fileprivate var width: CGFloat {
        switch self {
        case .mini: return 101
        case .small: return 163
        case .medium: return 303
        case .large: return 335
        }
    }
    
    fileprivate var cornerRadius: CGFloat {
        switch self {
        case .mini, .medium: return 10
        default: return 20
        }
    }
    
    fileprivate var font: UIFont {
        switch self {
        case .mini: return ResourceKitFontFamily.p2
        default: return ResourceKitFontFamily.h6
        }
    }
}

public final class MOITButton: UIView {
    
    private let flexRootView = UIView()
    private let titleLabel = UILabel()
    
    // MARK: - Properties
    
    private let type: MOITButtonType
    private let title: String
    private let titleColor: UIColor
    
    // MARK: - Initializers
    
    public init(
        type: MOITButtonType,
        title: String,
        titleColor: UIColor,
        backgroundColor: UIColor
    ) {
        self.type = type
        self.title = title
        self.titleColor = titleColor
        super.init(frame: .zero)
        self.flexRootView.backgroundColor = backgroundColor
        
        self.flexRootView.layer.cornerRadius = self.type.cornerRadius
        self.flexRootView.clipsToBounds = true
        self.configureTitleLabel(title: self.title, color: self.titleColor)
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("can not impl coder")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout(mode: .adjustWidth)
    }
}

// MARK: - Private functions

extension MOITButton {
    private func configureTitleLabel(
        title: String,
        color: UIColor
    ) {
        self.titleLabel.text = title
        self.titleLabel.textColor = color
        self.titleLabel.font = self.type.font
        self.titleLabel.numberOfLines = 1
        self.titleLabel.flex.markDirty()
        self.setNeedsLayout()
    }
    
    private func configureLayouts() {
        self.addSubview(self.flexRootView)
        self.flexRootView.flex
            .justifyContent(.center)
            .alignItems(.center)
            .define { flex in
                flex.addItem(self.titleLabel)
                    .height(23)
                    .marginHorizontal(12)
                    .marginVertical(self.type.marginVertical)
            }
            .width(self.type.width)
    }
}
