//
//  ParticipationSuccessViewController.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import MOITFoundation
import DesignSystem
import ResourceKit

import RIBs
import RxSwift

protocol ParticipationSuccessPresentableListener: AnyObject {
	func dismissButtonDidTap()
}

public final class ParticipationSuccessViewController: UIViewController,
													   ParticipationSuccessPresentable,
													   ParticipationSuccessViewControllable {

    weak var listener: ParticipationSuccessPresentableListener?
	
// MARK: - UI
	
	private let flexRootContainer = UIView()
	
	private let closeButton: UIButton = {
		let button = UIButton()
		button.setImage(ResourceKitAsset.Icon.x.image, for: .normal)
		return button
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.setTextWithParagraphStyle(
			text: StringResource.title.value,
			alignment: .center,
			font: ResourceKitFontFamily.h4,
			textColor: ResourceKitAsset.Color.gray900.color
		)
		return label
	}()
	
	private let profileImageView = MOITProfileView(
		profileImageType: .one,
		profileType: .large,
		addButton: false
	)
	
	private let moitNameLabel: UILabel = {
		let label = UILabel()
		label.setTextWithParagraphStyle(
			text: "전자군단",
			alignment: .center,
			font: ResourceKitFontFamily.h3,
			textColor: ResourceKitAsset.Color.gray900.color
		)
		return label
	}()
	
	private let moitDetailCardView = MOITDetailCardView()
	
	private let showStudyDetailButton = MOITButton(
		type: .large,
		title: StringResource.button.value,
		titleColor: ResourceKitAsset.Color.white.color,
		backgroundColor: ResourceKitAsset.Color.blue800.color
	)
	
// MARK: - property
	
	private let disposeBag = DisposeBag()
	
// MARK: - override
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		
		configureView()
		configureLayout()
		bind()
		
		// TODO: 추후 삭제
		moitDetailCardView.configure(
			viewModel: [
				MOITDetailInfoViewModel(
					title: "일정",
					description: "격주 금요일 17:00 - 20:00"
				),
				MOITDetailInfoViewModel(
					title: "규칙",
					description: "지각 15분부터 5,000원\n결석 30분 부터 8,000원"
				),
				MOITDetailInfoViewModel(
					title: "알람",
					description: "당일 오전 10시"
				),
				MOITDetailInfoViewModel(
					title: "기간",
					description: "2023년 6월 27일 - 2023년 8월 30일"
				)
			]
		)
	}
	
	override public func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootContainer.pin.all(view.pin.safeArea)
		flexRootContainer.flex.layout()
	}
	
// MARK: - private
	
	private func configureView() {
		view.backgroundColor = ResourceKitAsset.Color.white.color
		view.addSubview(flexRootContainer)
	}
	
	private func configureLayout() {
		flexRootContainer.flex
			.define { flex in
				flex.addItem()
					.justifyContent(.center)
					.alignItems(.end)
					.define { flex in
						flex.addItem(closeButton).marginRight(16)
					}
					.height(56)
				
				flex.addItem()
					.marginTop(33.4)
					.marginHorizontal(20)
					.grow(1)
					.define { flex in
						flex.addItem()
							.alignItems(.center)
							.define { flex in
								flex.addItem(titleLabel)
								flex.addItem(profileImageView).marginTop(60)
								flex.addItem(moitNameLabel).marginTop(10).height(36)
							}
						
						flex.addItem()
							.define { flex in
								flex.addItem(moitDetailCardView).marginTop(60)
							}
					}
				
				flex.addItem(showStudyDetailButton)
					.marginBottom(36)
					.marginHorizontal(20)
			}
	}
	
	private func bind() {
		closeButton.rx.tap
			.bind(onNext: { [weak self] _ in
				self?.listener?.dismissButtonDidTap()
			})
			.disposed(by: disposeBag)
	}
	
// MARK: - public
	
	// TODO: MOIT명, info setting
	public func configure() {
		
	}
}

extension ParticipationSuccessViewController {
	private enum StringResource {
		case button
		case title
		
		var value: String {
			switch self {
			case .button:
				return "스터디 둘러보기"
			case .title:
				return "스터디 참여 완료!\n새로운 스터디에 참여했어요"
			}
		}
	}
}
