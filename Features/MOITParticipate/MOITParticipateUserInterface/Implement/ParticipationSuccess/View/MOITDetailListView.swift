//
//  MOITDetailListView.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/20.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import FlexLayout
import PinLayout

public struct MOITDetailInfoViewModel {
	public let title: String
	public let description: String
	
	public init(
		title: String,
		description: String
	) {
		self.title = title
		self.description = description
	}
}

public typealias MOITDetailInfoViewModels = [MOITDetailInfoViewModel]

public final class MOITDetailListView: UIView {
	
// MARK: - UI
	  
	private let flexRootView = UIView()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.font = ResourceKitFontFamily.p3
		label.textColor = ResourceKitAsset.Color.gray800.color
		return label
	}()
	
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = ResourceKitFontFamily.p3
		label.textColor = ResourceKitAsset.Color.gray600.color
		label.numberOfLines = 0
		return label
	}()
	
// MARK: - init
	
	init(viewModel: MOITDetailInfoViewModel) {
		super.init(frame: .zero)
		
		self.confifugre(viewModel: viewModel)
		self.configureLayouts()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
// MARK: - override
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		self.flexRootView.pin.all()
		self.flexRootView.flex.layout()
	}
	
// MARK: - private
	
	private func configureLayouts() {
		self.addSubview(self.flexRootView)

		self.flexRootView.flex
			.direction(.row)
			.alignItems(.start)
			.define { flex in
				flex.addItem(self.titleLabel)
				
				flex.addItem(self.descriptionLabel)
					.marginLeft(12)
			}
	}
	
// MARK: - public
	
	public func confifugre(viewModel: MOITDetailInfoViewModel) {
		self.titleLabel.text = viewModel.title
		self.descriptionLabel.text = viewModel.description
		self.titleLabel.flex.markDirty()
		self.descriptionLabel.flex.markDirty()
		self.setNeedsLayout()
	}
}
