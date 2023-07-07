//
//  FineListView.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/07/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import FlexLayout
import PinLayout

final class FineListView: UIView {
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		return scrollView
	}()
	
	private let contentView = UIView()
	
	private let paymentListEmtpyLabel: UILabel = {
		let label = UILabel()
		label.text = "아직 벌금 미납자가 없어요"
		label.font = ResourceKitFontFamily.p3
		label.textColor = ResourceKitAsset.Color.gray600.color
		return label
	}()
	
	init() {
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
//		scrollView.flex.layout()
	}
	
	private func configureLayout() {
		scrollView.backgroundColor = .blue
		contentView.backgroundColor = .green
		addSubview(scrollView)
		scrollView.addSubview(contentView)
		
//		scrollView.flex.define { flex in
//			flex.addItem(contentView).grow(1)
//		}
	}
	
	func configureView(with fineItems: [FineList]) {
		contentView.flex
//			.justifyContent(.center)
//			.alignItems(.center)
			.define { flex in
//				flex.addItem(defaulterListEmptyLabel)
				for (index, list) in fineItems.enumerated() {
					if index == 0 {
						flex.addItem(list)
					} else {
						flex.addItem(list).marginTop(20)
					}
				}
			}
	}
	
	func configureEmptyView() {
		contentView.flex
			.justifyContent(.center)
			.alignItems(.center)
			.define { flex in
				flex.addItem(paymentListEmtpyLabel)
			}
	}
}
