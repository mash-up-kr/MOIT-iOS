//
//  MOITList.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/06/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import FlexLayout
import PinLayout

public final class MOITList: UIView {
	
	private let flexRootView = UIView()
	private let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 16
		imageView.clipsToBounds = true
		return imageView
	}()
	private let titleLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	private let detailLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	private let fineLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	private let type: MOITListType
	private let image: UIImage?
	private let title: String
	private let detail: String?
//	private let chipType: MOITChipType?
	private let fine: String?
	
// MARK: - init
	public init(
		type: MOITListType,
		image: UIImage? = nil,
		title: String,
		detail: String? = nil,
		fine: String? = nil
	) {
		self.type = type
		self.image = image
		self.title = title
		self.detail = detail
		self.fine = fine
		
		super.init(frame: .zero)
		
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
// MARK: - override
	override public func layoutSubviews() {
		super.layoutSubviews()

		flexRootView.pin.all()
		switch type {
			case .people:
				flexRootView.pin.height(41)
			default:
				flexRootView.pin.height(40)
		}
		flexRootView.flex.layout()
	}
	
// MARK: - private func
	private func configureLayout() {
		addSubview(flexRootView)
		
		flexRootView.flex
			.direction(.row)
			.define { flex in
				// TODO: MOITChip 추가
//				flex.addItem()
				flex.addItem(profileImageView)
				flex.addItem().direction(.column).define { flex in
					flex.addItem(titleLabel)
					flex.addItem(detailLabel)
				}
			}
		
		switch type {
			case .allAttend:
				<#code#>
			case .myAttend:
				<#code#>
			case .sendMoney:
				<#code#>
			case .myMoney:
				<#code#>
			case .people:
				<#code#>
		}
	}
	
	private func configureComponent() {
		if let image {
			profileImageView.image = image
		}
		
		titleLabel.text = title
		
		if let detail {
			detailLabel.text = detail
		}
		
		if let fine {
			fineLabel.text = fine
		}
	}
}
