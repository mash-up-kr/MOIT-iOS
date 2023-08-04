//
//  ParticipationSuccessViewController.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import MOITDetail
import Utils
import DesignSystem
import ResourceKit
import Utils

import RIBs
import RxSwift

protocol ParticipationSuccessPresentableListener: AnyObject {
	func dismissButtonDidTap()
	func viewDidLoad()
	func showStudyDetailButtonDidTap()
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
		
		listener?.viewDidLoad()
	}
	
	override public func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootContainer.pin.all(view.pin.safeArea)
		flexRootContainer.flex.layout()
	}
	
	deinit { debugPrint("\(self) deinit") }
	
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
		
		showStudyDetailButton.rx.tap
			.bind(onNext: { [weak self] _ in
				self?.listener?.showStudyDetailButtonDidTap()
			})
			.disposed(by: disposeBag)
	}
	
// MARK: - internal
	
	func configure(_ viewModel: MOITDetailProfileInfoViewModel) {
		moitNameLabel.text = viewModel.profileInfo.moitName
		profileImageView.configureImage(with: viewModel.profileInfo.imageUrl)
		moitDetailCardView.configure(viewModel: viewModel)
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
