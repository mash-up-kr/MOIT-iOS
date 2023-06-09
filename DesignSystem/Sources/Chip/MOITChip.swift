//
//  MOITChip.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/06/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import FlexLayout
import PinLayout

public final class MOITChip: UIView {
	
	private let flexRootView = UIView()
	private let titleLabel = UILabel()
	
	private let type: MOITChipType
	
	public init(
		type: MOITChipType
	) {
		self.type = type
		
		super.init(frame: .zero)
		
		configureFlexRootView()
		configureComponent()
		configureLayout()
	}
	
	@available (*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		flexRootView.pin.all()
		flexRootView.flex.layout(mode: .adjustWidth)
	}
	
	private func configureFlexRootView() {
		flexRootView.backgroundColor = type.backgroundColor
		flexRootView.layer.cornerRadius = type.cornerRadius
		flexRootView.clipsToBounds = true
	}
	
	private func configureComponent() {
		titleLabel.textColor = type.textColor
		titleLabel.text = type.title
		titleLabel.font = type.font
	}
	
	private func configureLayout() {
		addSubview(flexRootView)
		
		flexRootView.flex
			.alignItems(.center)
			.justifyContent(.center)
			.direction(.row)
			.define { flex in
				flex.addItem(titleLabel).marginHorizontal(type.marginHorizontal)
			}
			.height(type.height)
	}
}
