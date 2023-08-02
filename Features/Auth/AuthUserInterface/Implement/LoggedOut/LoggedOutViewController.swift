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
	func signInButtonDidTap()
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
	
// MARK: - UI
	
	private let flexRootContainer = UIView()
	
	private let ghostImageView = UIImageView(image: ResourceKitAsset.Icon.ghost.image)
	private let mainCharacterImageView = UIImageView(image: ResourceKitAsset.Icon.mainCharacter.image)
	private let logoImageView = UIImageView(image: ResourceKitAsset.Icon.signinLogo.image)
	
	private let titleDescriptionLabel: UILabel = {
		let label = UILabel()
		label.text = StringResource.titleDescription.value
		label.font = ResourceKitFontFamily.p2
		label.textColor = ResourceKitAsset.Color.whiteTransparent06.color
		return label
	}()
	
	private let signInButton = MOITButton(
		type: .large,
		title: StringResource.signInButtonTitle.value,
		titleColor: ResourceKitAsset.Color.white.color,
		backgroundColor: ResourceKitAsset.Color.blue800.color
	)
	
// MARK: - property
	
	weak var listener: LoggedOutPresentableListener?
	private let disposeBag = DisposeBag()
	private let lastGradientColor = UIColor(red: 236 / 255, green: 236 / 255, blue: 239 / 255, alpha: 1)
	
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
        navigationController?.navigationBar.isHidden = true
		configureView()
		configureLayout()
		bind()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootContainer.pin.all()
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
		
		flexRootContainer.flex.define { flex in

			flex.addItem()
				.alignItems(.end)
				.marginRight(22)
				.marginTop(52)
				.define { flex in
					flex.addItem(ghostImageView)
						.width(142)
						.height(137)
				}
			
			flex.addItem()
				.marginTop(26)
				.alignItems(.center)
				.grow(1)
				.define { flex in
					flex.addItem(titleDescriptionLabel)
					flex.addItem(logoImageView)
						.width(230)
						.height(80)
						.marginTop(6)
				}
			
			flex.addItem(mainCharacterImageView).position(.absolute)
			
			flex.addItem(signInButton)
				.marginHorizontal(20)
				.marginBottom(48)
		}
	}
	
	private func bind() {
		signInButton.rx.tap
			.bind(onNext: { [weak self] _ in
				self?.listener?.signInButtonDidTap()
			})
			.disposed(by: disposeBag)
	}
	
	private func addGradientLayer() {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = view.bounds
		
		gradientLayer.locations = [0.3, 0.6, 0.8]
		
		gradientLayer.colors = [
			ResourceKitAsset.Color.blue800.color.withAlphaComponent(0).cgColor,
			ResourceKitAsset.Color.blue800.color.withAlphaComponent(0.4).cgColor,
			lastGradientColor.cgColor
		]
		
		view.layer.addSublayer(gradientLayer)
	}
}

extension LoggedOutViewController {
	enum StringResource {
		case titleDescription
		case signInButtonTitle
		
		var value: String {
			switch self {
			case .titleDescription:
				return "스터디 출결 관리 서비스 모잇!"
			case .signInButtonTitle:
				return "모잇 시작하기"
			}
		}
	}
}
