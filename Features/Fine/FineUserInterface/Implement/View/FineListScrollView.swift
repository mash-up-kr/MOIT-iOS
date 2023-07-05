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
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.isPagingEnabled = true
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.backgroundColor = .systemPink
		return scrollView
	}()
	
	private let contentView = UIView()
	private let defaulterListView = UIView()
	private let paymentListView = UIView()

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

		scrollView.pin.all()
		contentView.pin.vertically().horizontally()
		
		defaulterListView.pin.width(100%)
		paymentListView.pin.width(100%)
		
		contentView.flex.layout(mode: .adjustWidth)
		scrollView.contentSize = contentView.frame.size
		
		defaulterListView.backgroundColor = .red
		paymentListView.backgroundColor = .blue
	}
	
// MARK: - private
	
	private func configureView() {
		addSubview(scrollView)
		scrollView.addSubview(contentView)

		contentView.flex
			.direction(.row)
			.define { flex in
				flex.addItem(defaulterListView)
				flex.addItem(paymentListView)
			}
		
//		defaulterListView.flex
//			.define { flex in
//				flex.addItem(defaulterListEmptyLabel).position(.absolute)
//			}
//
//		paymentListView.flex
//			.define { flex in
//				flex.addItem(paymentListEmtpyLabel).position(.absolute)
//			}
	}
}

extension FineListScrollView {
	enum StringResource {
		case paymentEmpty
		case defaulterEmpty
		
		var value: String {
			switch self {
			case .paymentEmpty:
				return "벌금 내역이 없어요"
			case .defaulterEmpty:
				return "아직 벌금 미납자가 없어요"
			}
		}
	}
}
