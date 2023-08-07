//
//  MasterAuthorizationView.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/07/30.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem
import ResourceKit

import FlexLayout
import PinLayout
import RxSwift
import RxCocoa

final class MasterAuthorizationView: UIView {
	
	fileprivate let cancelButton = MOITButton(
		type: .small,
		title: "취소",
		titleColor: ResourceKitAsset.Color.gray200.color,
		backgroundColor: ResourceKitAsset.Color.gray700.color
	)
	
	fileprivate let okButton = MOITButton(
		type: .small,
		title: "인증",
		titleColor: ResourceKitAsset.Color.white.color,
		backgroundColor: ResourceKitAsset.Color.blue800.color
	)
	
	private let titleLabel = UILabel()
	
	private let flexRootContainer = UIView()
	
	init(
		userNickname: String
	) {
		self.titleLabel.text = "\(userNickname)님의 벌금 납부를 인증할까요?"
		super.init(frame: .zero)
		configureLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		flexRootContainer.pin.all()
		flexRootContainer.flex.layout()
	}
	
	func configure(nickName: String) {
		titleLabel.setTextWithParagraphStyle(
			text: "\(nickName)님의 벌금 납부를 인증할까요?",
			alignment: .center,
			font: ResourceKitFontFamily.h6,
			textColor: ResourceKitAsset.Color.gray800.color
		)
		titleLabel.flex.markDirty()
		setNeedsLayout()
	}
	
	private func configureLayout() {
		addSubview(flexRootContainer)
		
		flexRootContainer.flex.define { flex in
			flex.addItem(titleLabel)
			
			flex.addItem()
				.marginTop(10)
				.direction(.row)
				.justifyContent(.spaceBetween)
				.define { flex in
					flex.addItem(cancelButton).width(47%)
					flex.addItem(okButton).width(47%)
				}
		}
	}
}

extension Reactive where Base: MasterAuthorizationView {
	var didTapCancelButton: Observable<Void> {
		base.cancelButton.rx.tap
	}
	
	var didTapOkButton: Observable<Void> {
		base.okButton.rx.tap
	}
}
