//
//  MOITDetailCardView.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/20.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import MOITDetail
import ResourceKit

import FlexLayout

public final class MOITDetailCardView: UIView {
	
// MARK: - UI
	
	private let flexRootContainer = UIView()
	private var infoViews: [MOITDetailListView] = []
	
// MARK: - init
	
	public init() {
		super.init(frame: .zero)
		configureView()
		configureLayouts()
	}
	
	@available (*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
// MARK: - override
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		flexRootContainer.pin.all()
		flexRootContainer.flex.layout()
	}
	
// MARK: - private
	
	private func configureView() {
		addSubview(flexRootContainer)
		
		backgroundColor = ResourceKitAsset.Color.gray50.color
		layer.cornerRadius = 20
		clipsToBounds = true	
	}
	
	private func configureLayouts() {
		flexRootContainer.flex
			.marginVertical(20)
			.marginLeft(20)
			.marginRight(35)
			.define { flex in
				self.infoViews.enumerated().forEach { index, infoView in
					if index != 0 {
						flex.addItem(infoView)
							.marginTop(9)
					} else {
						flex.addItem(infoView)
					}
				}
			}
	}
	
// MARK: - public
	public func configure(
		viewModel: MOITDetailProfileInfoViewModel
	) {
		self.infoViews = viewModel.detailInfos.map { infoViewModel in
			MOITDetailListView(viewModel: infoViewModel)
		}
		self.configureLayouts()
	}
}
