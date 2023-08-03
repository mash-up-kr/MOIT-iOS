//
//  MOITButton.swift
//  DesignSystem
//
//  Created by 송서영 on 2023/06/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit

import ResourceKit

import PinLayout
import FlexLayout
import RxSwift
import RxCocoa
import RxGesture

public final class MOITButton: UIView {
    
    // MARK: - UIComponents
    private let flexRootView = UIView()
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    
    // MARK: - Properties
    
    private let type: MOITButtonType
    private var title: String
    private let titleColor: UIColor
    private let image: UIImage?
    private let _backgroundColor: UIColor
    
    // MARK: - Initializers
    
    public init(
        type: MOITButtonType,
        image: UIImage? = nil,
        title: String,
        titleColor: UIColor,
        backgroundColor: UIColor
    ) {
        self._backgroundColor = backgroundColor
        self.image = image
        self.type = type
        self.title = title
        self.titleColor = titleColor
        super.init(frame: .zero)
        
        self.configureFlexRootView()
        self.configureTitleLabel(
            title: self.title,
            color: self.titleColor
        )
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("can not init from coder")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
    }
}

// MARK: - Private functions

extension MOITButton {
    
    private func configureFlexRootView() {
        self.flexRootView.backgroundColor = _backgroundColor
        self.flexRootView.layer.cornerRadius = self.type.cornerRadius
        self.flexRootView.clipsToBounds = true
    }
    
    private func configureTitleLabel(
        title: String,
        color: UIColor
    ) {
        self.titleLabel.text = title
        self.titleLabel.textColor = color
        self.titleLabel.font = self.type.font
        self.titleLabel.numberOfLines = 1
    }
    
    private func configureLayouts() {
        self.addSubview(self.flexRootView)
        
        self.flexRootView.flex
            .justifyContent(.center)
            .alignItems(.center)
            .direction(.row)
            .define { flex in
                if self.image != nil {
                    self.imageView.image = image
                    flex.addItem(self.imageView)
                        .size(29)
                }
                
                flex.addItem(self.titleLabel)
                    .height(23)
                    .marginHorizontal(12)
                    .marginVertical(self.type.marginVertical)
            }
//            .width(self.type.width)
    }
	
// MARK: - public
	
	public func configure(title: String) {
		self.title = title
		configureTitleLabel(
			title: title,
			color: titleColor
		)
	}
	
	public func configure(
		titleColor: ResourceKitColors,
		backgroundColor: ResourceKitColors
	) {
		titleLabel.textColor = titleColor.color
		flexRootView.backgroundColor = backgroundColor.color
	}
}

// MARK: - Reactive

extension Reactive where Base: MOITButton {
    public var tap: Observable<Void> {
        tapGesture()
            .when(.recognized)
            .throttle(
                .milliseconds(400),
                latest: false,
                scheduler: MainScheduler.instance
            )
            .map { _ in return }
    }
}
