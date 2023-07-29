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
import RxSwift
import RxCocoa

final class FineListScrollView: UIView {
	
// MARK: - UI
	
	private let flexRootContainer = UIView()
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.isPagingEnabled = true
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.isScrollEnabled = false
		return scrollView
	}()
	
	private let contentView = UIView()
	private let defaulterListView = FineListView(type: .defaulter)
	private let paymentListView = FineListView(type: .paymentList)
	
	private let segmentPager = MOITSegmentPager(
		pages: [StringResource.defaulter.value, StringResource.paymentList.value]
	)
	
	let selectedFineIDRelay = PublishRelay<Int>()

// MARK: - property
	
	private let disposeBag = DisposeBag()
	
// MARK: - init
	
	init() {
		super.init(frame: .zero)
		
		configureView()
		bind()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
// MARK: - override
	
	override func layoutSubviews() {
		super.layoutSubviews()

		flexRootContainer.pin.all()
		contentView.pin.all()
		contentView.flex.layout(mode: .adjustWidth)
		
		scrollView.contentSize = contentView.frame.size
		flexRootContainer.flex.layout()
	}
	
// MARK: - private
	
	private func configureView() {
		addSubview(flexRootContainer)
		
		flexRootContainer.flex
			.define { flex in
				flex.addItem(segmentPager)
				flex.addItem(scrollView)
					.marginVertical(20)
			}
		
		scrollView.flex
			.define { flex in
				flex.addItem(contentView)
			}

		contentView.flex
			.direction(.row)
			.define { flex in
				flex.addItem(defaulterListView).width(UIScreen.main.bounds.width - 40)
				flex.addItem(paymentListView).width(UIScreen.main.bounds.width - 40)
			}
		
		defaulterListView.selectedFineIDRelay
			.bind(to: selectedFineIDRelay)
		.disposed(by: disposeBag)
	}
	
	private func bind() {
		segmentPager.rx.tapIndex
			.bind(onNext: { [weak self] index in
				if index == 0 {
					self?.scrollView.scrollToLeft()
				} else {
					self?.scrollView.scrollToRight()
				}
			})
			.disposed(by: disposeBag)
	}
	
// MARK: - internal
	func configureView(with fineInfo: FineInfoViewModel) {
		defaulterListView.configureNotPaidFineListView(
			with: fineInfo.myNotPaidFineListViewModel,
			othersFineItem: fineInfo.othersNotPaidFineListViewModel
		)
		defaulterListView.flex.markDirty()

		paymentListView.configurePaymentCompletedFineListView(
			with: fineInfo.paymentCompletedFineListViewModel
		)
		paymentListView.flex.markDirty()
		setNeedsLayout()
	}
}

extension FineListScrollView {
	enum StringResource {
		case defaulter
		case paymentList
		
		var value: String {
			switch self {
			case .defaulter:
				return "벌금미납자"
			case .paymentList:
				return "납부 내역"
			}
		}
	}
}
