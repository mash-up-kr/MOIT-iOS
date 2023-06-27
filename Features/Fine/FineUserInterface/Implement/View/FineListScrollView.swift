//
//  FineListScrollView.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem

import FlexLayout
import PinLayout

final class FineListScrollView: UIView {
	
// MARK: - UI
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.isPagingEnabled = true
		return scrollView
	}()
	
	private let contentView = UIView()
	private let defaulterListView = UIView()
	private let paymentListView = UIView()

	private let fineListEmtpyLabel: UILabel = {
		let label = UILabel()
		// TODO: 피그마 수정 후 반영
		label.text = StringResource.empty.value
//		label.font =
//		label.textColor =
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
		contentView.pin.vertically().left()
		contentView.flex.layout(mode: .adjustWidth)
		scrollView.contentSize = contentView.frame.size
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
	}
}

extension FineListScrollView {
	enum StringResource {
		case empty
		
		var value: String {
			switch self {
			case .empty:
				return "벌금 내역이 없어요!"
			}
		}
	}
}
