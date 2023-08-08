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

open class MOITList: UIView {
	
// MARK: - UI

	private let flexRootView = UIView()
	
	private lazy var profileImageView: MOITProfileView? = {
		if let imageType {
			let imageView = MOITProfileView(
				profileImageType: imageType,
				profileType: .small
			)
			return imageView
		}
		
		return nil
	}()
	
	private lazy var titleLabel: UILabel? = {
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
	
	private lazy var studyOrderLabel: UILabel? = {
		if let studyOrder {
			let label = UILabel()
			label.text = "\(studyOrder)차 스터디"
			return label
		}
		
		return nil
	}()
	
	private lazy var separtaorLabel: UILabel = {
		let label = UILabel()
		label.text = "|"
		label.textColor = ResourceKitAsset.Color.gray600.color
		label.font = ResourceKitFontFamily.caption
		return label
	}()
	
	private lazy var fineLabel: UILabel? = {
		if let fine {
			let label = UILabel()
			let formattedFine = Formatter.fineFormatter.string(from: NSNumber(value: fine)) ?? ""
			label.text = "+ \(formattedFine) 원"
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
	
	fileprivate var button: MOITButton?
	
// MARK: - property
	
	private let type: MOITListType
	private var imageUrlString: String?
	private var title: String?
	private var detail: String?
	private var chipType: MOITChipType?
	private var studyOrder: Int?
	private var fine: Int?
    private var imageType: ProfileImageType?
	private var isButtonHidden: Bool
	
// MARK: - init
	public init(
		type: MOITListType,
		imageType: ProfileImageType? = nil,
		title: String? = nil,
		detail: String? = nil,
		chipType: MOITChipType? = nil,
		studyOrder: Int? = nil,
		fine: Int? = nil,
		button: MOITButton? = nil,
		isButtonHidden: Bool = true
	) {
		self.type = type
		self.imageType = imageType
		self.title = title
		self.detail = detail
		self.chipType = chipType
		self.studyOrder = studyOrder
		self.fine = fine
		self.button = button
		self.isButtonHidden = isButtonHidden
		
		super.init(frame: .zero)
		
		configureLayout()
	}
	
	required public init?(coder: NSCoder) {
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
					flex.addOptionalItem(chip, marginRight: 10)
				}

				flex.addItem().direction(.column)
					.grow(1)
					.justifyContent(.center)
					.define { flex in
						
						if let studyOrderLabel, type == .myMoney {
							studyOrderLabel.setTitleStyle()
							flex.addItem(studyOrderLabel)
						} else {
							flex.addOptionalItem(titleLabel)
						}
						
						flex.addItem().direction(.row).define { flex in
								flex.addOptionalItem(detailLabel)
									
								if let studyOrderLabel, type == .sendMoney {
									studyOrderLabel.setDetailLabelStyle()
									flex.addItem(separtaorLabel).marginHorizontal(3)
									flex.addItem(studyOrderLabel)
								}
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

extension UILabel {
	func setDetailLabelStyle() {
		self.textColor = ResourceKitAsset.Color.gray600.color
		self.font = ResourceKitFontFamily.caption
	}
	
	func setTitleStyle() {
		self.font = ResourceKitFontFamily.h6
		self.textColor = ResourceKitAsset.Color.gray900.color
	}
}

enum Formatter {
	static let fineFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		return formatter
	}()
}


extension MOITList {
	public func configure(
		title: String?,
		detail: String?,
		chipType: MOITChipType? = nil,
		isButtonHidden: Bool = true,
		buttonTitle: String? = nil,
		studyOrder: Int? = nil
	) {
        self.titleLabel?.text = title
        self.detailLabel?.text = detail
		
		if let chipType {
			self.chip?.setType(to: chipType)
			self.chip?.flex.markDirty()
		}
		
		if isButtonHidden {
			button?.flex.display(.none)
		} else if let title = buttonTitle {
			button?.flex.display(.flex)
			button?.configure(title: title)
		}
		
		if let studyOrder {
			self.studyOrder = studyOrder
			self.studyOrderLabel?.text = "\(studyOrder)차 스터디"
			self.studyOrderLabel?.flex.markDirty()
		}
        
		self.button?.flex.markDirty()
        self.titleLabel?.flex.markDirty()
        self.detailLabel?.flex.markDirty()
        
        self.flexRootView.setNeedsLayout()
    }
}
