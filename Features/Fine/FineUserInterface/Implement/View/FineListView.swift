//
//  FineListView.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/07/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit
import Utils

import FlexLayout
import PinLayout

enum FineListViewType {
	case defaulter
	case paymentList
	
	var emptyText: String {
		switch self {
		case .defaulter:
			return "아직 벌금 미납자가 없어요"
		case .paymentList:
			return "벌금 내역이 없어요"
		}
	}
}

final class FineListView: UIView {
	
// MARK: - UI
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		return scrollView
	}()
	
	private let contentView = UIView()
	
	private lazy var emptyLabel: UILabel = {
		let label = UILabel()
		label.setTextWithParagraphStyle(
			text: type.emptyText,
			alignment: .center,
			font: ResourceKitFontFamily.p3,
			textColor: ResourceKitAsset.Color.gray600.color
		)
		return label
	}()
	
// MARK: - property
	
	private let type: FineListViewType
	
	init(
		type: FineListViewType
	) {
		self.type = type
		super.init(frame: .zero)
		configureLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	
		scrollView.pin.all()
		contentView.pin.top().horizontally()
		contentView.flex.layout(mode: .adjustHeight)
		scrollView.contentSize = contentView.frame.size
	}
	
	private func configureLayout() {
		addSubview(scrollView)
		scrollView.addSubview(contentView)
	}
	
	func configureView(with fineItems: [FineList]) {
		if fineItems.isEmpty {
			contentView.flex
				.alignSelf(.center)
				.define { flex in
					flex.addItem(emptyLabel).marginVertical(43)
				}
		} else {
			contentView.flex
				.define { flex in
					for (index, list) in fineItems.enumerated() {
						if index == 0 {
							flex.addItem(list)
						} else {
							flex.addItem(list).marginTop(20)
						}
					}
				}
		}
	}
}
