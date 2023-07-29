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
import RxCocoa
import RxSwift

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
	
	private let separatorView: UIView = {
		let view = UIView()
		view.backgroundColor = ResourceKitAsset.Color.gray100.color
		return view
	}()
	
	fileprivate var fineListViews: [NotPaidFineListView] = []
	
	let selectedFineIDRelay = PublishRelay<Int>()
	private let disposeBag = DisposeBag()
	
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
		contentView.pin.top().horizontally().bottom()
		contentView.flex.layout()

		scrollView.contentSize = contentView.frame.size
		scrollView.flex.layout(mode: .adjustHeight)
	}
	
	private func configureLayout() {
		addSubview(scrollView)
		scrollView.addSubview(contentView)
	}
	
	func configureNotPaidFineListView(
		with myFineItem: [NotPaidFineListViewModel],
		othersFineItem: [NotPaidFineListViewModel]
	) {
		
		let fineList = myFineItem + othersFineItem
		
		if fineList.isEmpty {
			contentView.flex
				.alignSelf(.center)
				.define { flex in
					flex.addItem(emptyLabel).marginVertical(43)
				}
		} else {
			contentView.flex
				.define { flex in
					let myFineListViews = myFineItem.map { NotPaidFineListView(fineViewModel: $0) }
					let othersFineListViews = othersFineItem.map { NotPaidFineListView(fineViewModel: $0) }
					
					self.fineListViews = myFineListViews + othersFineListViews
					
					fineListViews.forEach { view in
						view.rx.tappedFineID
							.bind(to: selectedFineIDRelay)
							.disposed(by: disposeBag)
					}
					
					for (index, list) in myFineListViews.enumerated() {
						if index == 0 {
							flex.addItem(list)
						} else {
							flex.addItem(list).marginTop(20)
						}
					}
					
					if !myFineListViews.isEmpty && !othersFineListViews.isEmpty {
						flex.addItem(separatorView).marginTop(20).height(1)
					}
					
					for (index, list) in othersFineListViews.enumerated() {
						if myFineListViews.isEmpty && index == 0 {
							flex.addItem(list)
						} else {
							flex.addItem(list).marginTop(20)
						}
					}
				}
		}
	}
	
	func configurePaymentCompletedFineListView(with fineList: [PaymentCompletedFineListViewModel]) {
		if fineList.isEmpty {
			contentView.flex
				.alignSelf(.center)
				.define { flex in
					flex.addItem(emptyLabel).marginVertical(43)
				}
		} else {
			contentView.flex
				.define { flex in
					let paymentComptetedFineListViews = fineList.map { PaymentCompletedFineListView(fineViewModel: $0) }
					
					for (index, list) in paymentComptetedFineListViews.enumerated() {
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


