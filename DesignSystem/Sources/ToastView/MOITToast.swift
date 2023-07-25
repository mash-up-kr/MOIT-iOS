//
//  MOITToast.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/07/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import FlexLayout
import PinLayout

public final class MOITToast: UIView {
	
// MARK: - UI
	
	private let flexRootView: UIView = {
		let view = UIView()
		view.backgroundColor = ResourceKitAsset.Color.gray800.color
		view.layer.cornerRadius = 10
		view.clipsToBounds = true
		return view
	}()
	private let iconView = UIImageView()
	private var label: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = ResourceKitFontFamily.p2
		label.textColor = ResourceKitAsset.Color.white.color
		return label
	}()
	
// MARK: - init

	public init(
		toastType: MOITToastType,
		text: String
	) {
		super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
		
		configureLayout()
		configure(
			toastType: toastType,
			text: text
		)
	}
	
	@available (*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
// MARK: - override
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		
		flexRootView.pin.all()
		flexRootView.flex.layout()
	}
	
// MARK: - private
	
	private func configure(
		toastType: MOITToastType,
		text: String
	) {
		iconView.image = toastType.image
		label.text = text
	}
	
	private func configureLayout() {
		addSubview(flexRootView)
		
		flexRootView.flex
			.marginHorizontal(20)
			.define { flex in
				flex.addItem()
					.alignItems(.center)
					.marginHorizontal(17)
					.marginVertical(20)
					.direction(.row)
					.define { flex in
						flex.addItem(iconView).width(24).height(24)
						flex.addItem(label).marginLeft(8)
				}
			}
			.height(64)
	}
}
