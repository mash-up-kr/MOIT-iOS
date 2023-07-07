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

protocol FineListPresentableListener: AnyObject {
	func fineListDidTap(with fineItem: FineItem)
}

final class FineListViewController: UIViewController, FineListPresentable, FineListViewControllable {

// MARK: - UI
	
	private let flexRootContainer = UIView()
	
	private let fineTitleLabel: UILabel = {
		let label = UILabel()
		label.setTextWithParagraphStyle(
			text: StringResource.title.value,
			font: ResourceKitFontFamily.h5,
			textColor: ResourceKitAsset.Color.gray700.color
		)
		return label
	}()
	
	private let fineAmountLabel = UILabel()
	
	private let fineUnitLabel: UILabel = {
		let label = UILabel()
		label.setTextWithParagraphStyle(
			text: StringResource.unit.value,
			font: ResourceKitFontFamily.h3,
			textColor: ResourceKitAsset.Color.gray900.color
		)
		return label
	}()

	private let fineListScrollView = FineListScrollView()
	
// MARK: - property
	
    weak var listener: FineListPresentableListener?
	private let disposeBag = DisposeBag()
	
// MARK: - override
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureView()
		configureLayout()
		bind()
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
		fineAmountLabel.setTextWithParagraphStyle(
			text: "50,000",
			font: ResourceKitFontFamily.h2,
			textColor: ResourceKitAsset.Color.gray900.color
		)
	}
	
	private func configureLayout() {
		flexRootContainer.flex.define { flex in
			flex.addItem(fineTitleLabel).marginTop(300)
			
			flex.addItem().direction(.row).define { flex in
				flex.addItem(fineAmountLabel)
				flex.addItem(fineUnitLabel)
			}

			flex.addItem(fineListScrollView).marginTop(20).grow(1)
		}
	}
	
	private func bind() {
		fineListScrollView.rx.tappedListItem
			.bind(onNext: { [weak self] item in
				self?.listener?.fineListDidTap(with: item)
			})
			.disposed(by: disposeBag)
	}
}

extension FineListViewController {
	enum StringResource {
		case title
		case unit

		var value: String {
			switch self {
			case .title:
				return "오늘까지 모인 벌금"
			case .unit:
				return "원"
			}
		}
	}
}
