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
	private let defaulterListView = FineListView()
	private let paymentListView = FineListView()
	
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
	
// MARK: - property
	
	private let disposeBag = DisposeBag()
	fileprivate let myDefaulterList = [
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 15000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .late,
				studyOrder: 3,
				isApproved: false,
				approveAt: ""
			)
		),
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 20000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .absent,
				studyOrder: 4,
				isApproved: false,
				approveAt: ""
			)
		),
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 20000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .absent,
				studyOrder: 4,
				isApproved: false,
				approveAt: ""
			)
		),
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 20000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .absent,
				studyOrder: 4,
				isApproved: false,
				approveAt: ""
			)
		),
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 20000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .absent,
				studyOrder: 4,
				isApproved: false,
				approveAt: ""
			)
		),FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 20000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .absent,
				studyOrder: 4,
				isApproved: false,
				approveAt: ""
			)
		),
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 20000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .absent,
				studyOrder: 4,
				isApproved: false,
				approveAt: ""
			)
		),
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 20000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .absent,
				studyOrder: 4,
				isApproved: false,
				approveAt: ""
			)
		),
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 20000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .absent,
				studyOrder: 4,
				isApproved: false,
				approveAt: ""
			)
		),
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 15000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .late,
				studyOrder: 3,
				isApproved: false,
				approveAt: ""
			)
		),
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 15000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .late,
				studyOrder: 3,
				isApproved: false,
				approveAt: ""
			)
		),
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 15000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .late,
				studyOrder: 3,
				isApproved: false,
				approveAt: ""
			)
		),
		FineList(
			fineItem: FineItem(
				id: 0,
				fineAmount: 15000,
				userID: 0,
				userNickname: "전자군단대장",
				attendanceStatus: .late,
				studyOrder: 3,
				isApproved: false,
				approveAt: ""
			)
		)
	]
	
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
		scrollView.backgroundColor = .systemPink
		
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
		
		defaulterListView.configureView(with: myDefaulterList)

//		defaulterListView.flex
////			.justifyContent(.center)
////			.alignItems(.center)
//			.define { flex in
////				flex.addItem(defaulterListEmptyLabel)
//				for (index, list) in myDefaulterList.enumerated() {
//					if index == 0 {
//						flex.addItem(list)
//					} else {
//						flex.addItem(list).marginTop(20)
//					}
//				}
//			}
//
//		paymentListView.flex
//			.justifyContent(.center)
//			.alignItems(.center)
//			.define { flex in
//				flex.addItem(paymentListEmtpyLabel)
//			}
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

// TODO: 추후 Utils로 이동
extension UIScrollView {
	func scrollToRight() {
		let rightOffset = CGPoint(x: contentInset.right + bounds.width, y: 0)
		setContentOffset(rightOffset, animated: true)
	}
	
	func scrollToLeft() {
		let leftOffset = CGPoint(x: -contentInset.left, y: 0)
		setContentOffset(leftOffset, animated: true)
	}
}

// MARK: - Reactive
extension Reactive where Base: FineListScrollView {
	
	var tappedListItem: Observable<FineItem> {
		
		let observables = base.myDefaulterList.enumerated().map { index, list in
			list.rx.tap
				.map { _ in list.item }
		}

		return Observable.merge(observables)
	}
}
