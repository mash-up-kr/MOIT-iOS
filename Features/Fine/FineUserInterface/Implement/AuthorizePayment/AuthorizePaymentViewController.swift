//
//  AuthorizePaymentViewController.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem
import ResourceKit

import RIBs
import RxSwift
import FlexLayout
import PinLayout

protocol AuthorizePaymentPresentableListener: AnyObject {
	func dismissButtonDidTap()
}

final class AuthorizePaymentViewController: UIViewController, AuthorizePaymentPresentable, AuthorizePaymentViewControllable {

// MARK: - UI
	
	private let flexRootContainer = UIView()
	
	private let navigationBar = MOITNavigationBar(
		leftItems: [.back],
		title: StringResource.title.value,
		rightItems: []
	)
	
	private let fineDetailList = MOITList(
		type: .sendMoney,
		title: "김모잇",
		detail: "15,000원",
		chipType: .late,
		studyOrder: 1
	)
	
	private let fineImageView = FineImageView()
	
	private let authenticateButton = MOITButton(
		type: .large,
		image: nil,
		title: StringResource.title.value,
		titleColor: ResourceKitAsset.Color.gray700.color,
		backgroundColor: ResourceKitAsset.Color.gray200.color
	)
	
// MARK: - property
	
    weak var listener: AuthorizePaymentPresentableListener?
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
	}
	
	private func configureLayout() {
		flexRootContainer.flex.define { flex in
			flex.addItem(navigationBar)
			
			flex.addItem()
				.marginTop(20)
				.marginHorizontal(20)
				.grow(1)
				.define { flex in
					
					flex.addItem(fineDetailList)
					flex.addItem(fineImageView).marginTop(20)
				}
			
			flex.addItem(authenticateButton).marginHorizontal(20)
		}
	}
	
	private func bind() {
		navigationBar.leftItems?.first?.rx.tap
			.bind(onNext: { [weak self] _ in
				self?.listener?.dismissButtonDidTap()
			})
			.disposed(by: self.disposeBag)
	}
}

extension AuthorizePaymentViewController {
	enum StringResource {
		case title
		case uploadGuide
		
		var value: String {
			switch self {
			case .title:
				return "벌금 납부 인증하기"
			case .uploadGuide:
				return "여기를 눌러 벌금을 납부한\n스크린샷을 업로드해주세요!"
			}
		}
	}
}
