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
    
    fileprivate var width: CGFloat {
        switch self {
        case .mini: return 89
        case .small: return 163
        case .medium: return 303
        case .large: return 335
        }
    }
    
    fileprivate var cornerRadius: CGFloat {
        switch self {
        case .mini: return 10
        default: return 20
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
        self.backgroundColor = backgroundColor
        
        self.layer.cornerRadius = self.type.cornerRadius
        self.clipsToBounds = true
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
    } // 혜린이가 함
    
    private func configureLayouts() {
        self.addSubview(self.flexRootView)
        ++
        self.flexRootView.flex
            .justifyContent(.center)
            .alignItems(.center)
            .define { flex in
                flex.addItem(self.titleLabel)
                    .marginVertical(self.type.marginVertical)
                    .marginHorizontal(self.type.)
//                    .width(self.type.width)
            }
    }
}
