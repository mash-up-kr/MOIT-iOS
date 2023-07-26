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

struct FineInfo {
	let totalFineAmount: Int
	let fineNotYet, fineComplete: [FineItem]
}

struct FineItem {
	let id, fineAmount, userID: Int
	let userNickname: String
	let attendanceStatus: MOITChipType
	let studyOrder: Int
	let isApproved: Bool
	let approveAt: String
}

final class FineList: MOITList {
	var item: FineItem {
		self.fineItem
	}
	
	private let fineItem: FineItem
	
	private let button = MOITButton(
		type: .mini,
		title: "납부 인증하기",
		titleColor: ResourceKitAsset.Color.white.color,
		backgroundColor: ResourceKitAsset.Color.black.color
	)
	
	init(fineItem: FineItem) {
		self.fineItem = fineItem
		super.init(
			type: .sendMoney,
			title: fineItem.userNickname,
			detail: "\(fineItem.fineAmount)원",
			chipType: fineItem.attendanceStatus,
			studyOrder: fineItem.studyOrder,
			button: button
		)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

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
		flexRootContainer.flex.layout()
		
		contentView.flex.layout(mode: .adjustWidth)
		
		scrollView.contentSize = contentView.frame.size
		scrollView.flex.layout()
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
				flex.addItem(defaulterListView).width(UIScreen.main.bounds.width - 40)
				flex.addItem(paymentListView).width(UIScreen.main.bounds.width - 40)
			}
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
	func configureView(with fineInfo: FineInfo) {
		defaulterListView.configureView(with: fineInfo.fineNotYet.map { FineList(fineItem: $0) } )
		paymentListView.configureView(with: fineInfo.fineComplete.map { FineList(fineItem: $0) })
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

// MARK: - Reactive
extension Reactive where Base: FineListScrollView {
	
	// TODO: 여기서 index만 넘길까?
//	var tappedListItem: Observable<FineItem> {
//		
//		let observables = base.myDefaulterList.map { list in
//			list.rx.tap
//				.map { _ in list.item }
//		}
//
//		return Observable.merge(observables)
//	}
}
