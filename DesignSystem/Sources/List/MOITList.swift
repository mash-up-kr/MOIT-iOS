//
//  MOITList.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/06/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import FlexLayout
import PinLayout
import RxSwift

public final class MOITList: UIView {
	
// MARK: - UI
	
	private let flexRootView = UIView()
	
	private lazy var profileImageView: MOITProfileView? = {
		if let imageUrlString {
			let imageView = MOITProfileView(
				urlString: imageUrlString,
				profileType: .small
			)
			return imageView
		}
		
		return nil
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = title
		label.font = ResourceKitFontFamily.h6
		label.textColor = ResourceKitAsset.Color.gray900.color
		return label
	}()
	
	private lazy var detailLabel: UILabel? = {
		if let detail {
			let label = UILabel()
			label.text = detail
			label.textColor = ResourceKitAsset.Color.gray600.color
			label.font = ResourceKitFontFamily.caption
			return label
		}
		
		return nil
	}()
	
	private lazy var fineLabel: UILabel? = {
		if let fine {
			let label = UILabel()
			label.text = fine
			label.textColor = ResourceKitAsset.Color.gray900.color
			label.font = ResourceKitFontFamily.h5
			return label
		}
		
		return nil
	}()
	
	private lazy var chip: MOITChip? = {
		if let chipType {
			return MOITChip(type: chipType)
		}
		
		return nil
	}()
	
	fileprivate let button: MOITButton?
	
// MARK: - property
	
	private let type: MOITListType
	private let imageUrlString: String?
	private let title: String
	private let detail: String?
	private let chipType: MOITChipType?
	private let fine: String? // TODO: 이부분도 서버에서 String, Int 중 어떤 형식으로 내려줄지?
	
// MARK: - init
	public init(
		type: MOITListType,
		imageUrlString: String? = nil,
		title: String,
		detail: String? = nil,
		chipType: MOITChipType? = nil,
		fine: String? = nil,
		button: MOITButton? = nil
	) {
		self.type = type
		self.imageUrlString = imageUrlString
		self.title = title
		self.detail = detail
		self.chipType = chipType
		self.fine = fine
		self.button = button
		
		super.init(frame: .zero)
		
		configureLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
// MARK: - override
	override public func layoutSubviews() {
		super.layoutSubviews()

		flexRootView.pin.all()
		flexRootView.flex.layout()
	}
	
// MARK: - private func
	private func configureLayout() {
		addSubview(flexRootView)

		flexRootView.flex
			.direction(.row)
			.alignItems(.center)
			.height(type.height)
			.define { flex in
				if let profileImageView {
					flex.addItem(profileImageView).marginRight(10)
				}
				
				if [.sendMoney, .myMoney].contains(where: { $0 == type }) {
					if let chip {
						flex.addItem(chip).marginRight(10)
					}
				}

				flex.addItem().direction(.column)
					.grow(1)
					.justifyContent(.center)
					.define { flex in
					flex.addItem(titleLabel)
					
					if let detailLabel {
						flex.addItem(detailLabel)
					}
				}
				
				if let additionalView = selectAdditionalView(type: type) {
					flex.addItem(additionalView)
				}
			}
	}
	
	private func selectAdditionalView(type: MOITListType) -> UIView? {
		let targetView: UIView?

		switch type {
		case .allAttend, .myAttend:
			targetView = chip
		case .sendMoney:
			targetView = button
		case .myMoney:
			targetView = fineLabel
		case .people:
			targetView = nil
		}
		return targetView
	}
}

// MARK: - Reactive
extension Reactive where Base: MOITList {
	public var tap: Observable<Void> {
		base.button?.rx.tap.asObservable() ?? Observable.empty()
	}
}

