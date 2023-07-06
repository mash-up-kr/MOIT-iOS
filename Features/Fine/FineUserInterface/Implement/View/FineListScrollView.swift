//
//  FineListScrollView.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem
import ResourceKit

import FlexLayout
import PinLayout

final class FineListScrollView: UIView {
	
// MARK: - UI
	
	private let flexRootContainer = UIView()
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.isPagingEnabled = true
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.backgroundColor = .systemPink
		return scrollView
	}()
	
	private let contentView = UIView()
	private let defaulterListView = UIView()
	private let paymentListView = UIView()
	
	private let segmentPager = MOITSegmentPager(
		pages: [StringResource.defaulter.value, StringResource.paymentList.value]
	)

	private let paymentListEmtpyLabel: UILabel = {
		let label = UILabel()
		label.text = StringResource.paymentEmpty.value
		label.font = ResourceKitFontFamily.p3
		label.textColor = ResourceKitAsset.Color.gray600.color
		return label
	}()
	
	private let defaulterListEmptyLabel: UILabel = {
		let label = UILabel()
		label.text = StringResource.defaulterEmpty.value
		label.font = ResourceKitFontFamily.p3
		label.textColor = ResourceKitAsset.Color.gray600.color
		return label
	}()
	
// MARK: - init
	
	init() {
		super.init(frame: .zero)
		configureView()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
// MARK: - override
	
	override func layoutSubviews() {
		super.layoutSubviews()

		flexRootContainer.pin.all()
		flexRootContainer.flex.layout()
		
		contentView.flex.layout(mode: .adjustWidth)
		
		scrollView.contentSize = contentView.frame.size
		scrollView.flex.layout()
		
		defaulterListView.backgroundColor = .red
		paymentListView.backgroundColor = .blue
	}
	
// MARK: - private
	
	private func configureView() {
		
		addSubview(flexRootContainer)
		
		flexRootContainer.flex
			.define { flex in
				flex.addItem(segmentPager).marginBottom(20)
				flex.addItem(scrollView).grow(1)
			}
		
		scrollView.flex
			.define { flex in
				flex.addItem(contentView).grow(1)
			}

		contentView.flex
			.direction(.row)
			.define { flex in
				flex.addItem(defaulterListView).width(UIScreen.main.bounds.width)
				flex.addItem(paymentListView).width(UIScreen.main.bounds.width)
			}
		
		defaulterListView.flex
			.justifyContent(.center)
			.alignItems(.center)
			.define { flex in
				flex.addItem(defaulterListEmptyLabel)
			}

		paymentListView.flex
			.justifyContent(.center)
			.alignItems(.center)
			.define { flex in
				flex.addItem(paymentListEmtpyLabel)
			}
	}
}

extension FineListScrollView {
	enum StringResource {
		case paymentEmpty
		case defaulterEmpty
		case defaulter
		case paymentList
		
		var value: String {
			switch self {
			case .defaulter:
				return "벌금미납자"
			case .paymentList:
				return "납부 내역"
			case .paymentEmpty:
				return "벌금 내역이 없어요"
			case .defaulterEmpty:
				return "아직 벌금 미납자가 없어요"
			}
		}
	}
}
