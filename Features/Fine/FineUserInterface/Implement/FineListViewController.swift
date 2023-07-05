//
//  FineListViewController.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit
import DesignSystem

import RIBs
import RxSwift
import FlexLayout
import PinLayout

protocol FineListPresentableListener: AnyObject { }

final class FineListViewController: UIViewController, FineListPresentable, FineListViewControllable {

// MARK: - UI
	
	private let flexRootContainer = UIView()
	
	private let fineTitleLabel: UILabel = {
		let label = UILabel()
		label.text = StringResource.title.value
		label.font = ResourceKitFontFamily.h5
		label.textColor = ResourceKitAsset.Color.gray700.color
		return label
	}()
	
	private let fineAmountLabel: UILabel = {
		let label = UILabel()
		label.font = ResourceKitFontFamily.h2
		label.textColor = ResourceKitAsset.Color.gray900.color
		return label
	}()
	
	private let fineUnitLabel: UILabel = {
		let label = UILabel()
		label.text = StringResource.unit.value
		label.font = ResourceKitFontFamily.h3
		label.textColor = ResourceKitAsset.Color.gray900.color
		return label
	}()
	
	private let segmentPager = MOITSegmentPager(
		pages: [StringResource.defaulter.value, StringResource.paymentList.value]
	)
	
	private let fineListScrollView = FineListScrollView()
	
// MARK: - property
	
    weak var listener: FineListPresentableListener?
	
// MARK: - override
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureView()
		configureLayout()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootContainer.pin.all(view.pin.safeArea)
		flexRootContainer.flex.layout()
	}
	
// MARK: - private
	
	private func configureView() {
		view.backgroundColor = .white
		view.addSubview(flexRootContainer)
		
		// TODO: 추후 삭제
		fineAmountLabel.text = "50,000"
	}
	
	private func configureLayout() {
		flexRootContainer.flex.define { flex in
			flex.addItem(fineTitleLabel).marginTop(20)
			
			flex.addItem().direction(.row).define { flex in
				flex.addItem(fineAmountLabel)
				flex.addItem(fineUnitLabel)
			}
			
			flex.addItem(segmentPager).marginTop(20)
			flex.addItem(fineListScrollView).marginTop(20).grow(1)
		}
	}
}

extension FineListViewController {
	enum StringResource {
		case title
		case unit
		case defaulter
		case paymentList
		
		var value: String {
			switch self {
			case .title:
				return "오늘까지 모인 벌금"
			case .unit:
				return "원"
			case .defaulter:
				return "벌금미납자"
			case .paymentList:
				return "납부 내역"
			}
		}
	}
}
