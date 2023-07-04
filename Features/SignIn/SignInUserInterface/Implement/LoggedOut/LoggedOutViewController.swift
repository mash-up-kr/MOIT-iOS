//
//  LoggedOutViewController.swift
//  SignInUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem
import ResourceKit

import FlexLayout
import PinLayout
import RIBs
import RxSwift

protocol LoggedOutPresentableListener: AnyObject {
	func kakaoSignInButtonDidTap()
	func appleSignInButtonDidTap()
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
	
// MARK: - UI
	
	private let flexRootContainer = UIView()
	
	private let ghostImageView = UIImageView(image: ResourceKitAsset.Icon.ghost.image)
	private let mainCharacterImageView = UIImageView(image: ResourceKitAsset.Icon.mainCharacter.image)
	private let logoImageView = UIImageView(image: ResourceKitAsset.Icon.logo.image)
	
	private let titleDescriptionLabel: UILabel = {
		let label = UILabel()
		label.text = StringResource.titleDescription.value
		label.font = ResourceKitFontFamily.p2
		label.textColor = ResourceKitAsset.Color.whiteTransparent06.color
		return label
	}()
	
	private let kakaoSignInButton = MOITButton(
		type: .large,
		image: ResourceKitAsset.Icon.kakaotalk.image,
		title: "카카오톡으로 시작하기",
		titleColor: .black,
		backgroundColor: ResourceKitAsset.Color.kakao.color
	)
	
	private let appleSignInButton = MOITButton(
		type: .large,
		image: ResourceKitAsset.Icon.apple.image,
		title: "Apple로 시작하기",
		titleColor: .white,
		backgroundColor: .black
	)
	
// MARK: - property
	
	private let disposeBag = DisposeBag()
	
// MARK: - init
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
// MARK: - override
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureView()
		configureLayout()
		bind()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootContainer.pin.all(view.pin.safeArea).marginHorizontal(0).marginBottom(48)
		flexRootContainer.flex.layout()
		
		mainCharacterImageView.pin.horizontally().bottom(124)
	}
	
// MARK: - private
	
	private func configureView() {
		view.backgroundColor = ResourceKitAsset.Color.gray900.color
		addGradientLayer()
	}
	
	private func configureLayout() {
		view.addSubview(flexRootContainer)
		
		flexRootContainer.flex.direction(.columnReverse).define { flex in
			flex.addItem(mainCharacterImageView).position(.absolute)
			flex.addItem(appleSignInButton).marginTop(12).marginHorizontal(20)
			flex.addItem(kakaoSignInButton).marginHorizontal(20)
		}
	}
	
	private func bind() {
		kakaoSignInButton.rx.tap
			.subscribe(
				onNext: { [weak self] _ in
					self?.listener?.kakaoSignInButtonDidTap()
				}
			)
			.disposed(by: disposeBag)
		
		appleSignInButton.rx.tap
			.subscribe(
				onNext: { [weak self] _ in
					self?.listener?.appleSignInButtonDidTap()
				}
			)
			.disposed(by: disposeBag)
	}
	
	private func addGradientLayer() {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = view.bounds
		
		gradientLayer.locations = [0.4, 0.7]
		
		gradientLayer.colors = [
			ResourceKitAsset.Color.blue800.color.withAlphaComponent(0).cgColor,
			ResourceKitAsset.Color.blue800.color.withAlphaComponent(0.4).cgColor,
			UIColor(red: 236 / 255, green: 236 / 255, blue: 239 / 255, alpha: 1).cgColor
		]
		
		view.layer.addSublayer(gradientLayer)
	}
}

extension LoggedOutViewController {
	enum StringResource {
		case titleDescription
		
		var value: String {
			switch self {
			case .titleDescription:
				return "스터디 출결 관리 서비스 모잇!"
			}
		}
	}
}
