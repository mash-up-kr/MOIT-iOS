//
//  InputParticipateCodeViewController.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem
import ResourceKit

import RIBs
import RxCocoa
import RxSwift

protocol InputParticipateCodePresentableListener: AnyObject {
	func joinMOITButtonDidTap(code: String)
}

public final class InputParticipateCodeViewController: UIViewController,
													   InputParticipateCodePresentable,
													   InputParticipateCodeViewControllable {

    weak var listener: InputParticipateCodePresentableListener?
	
// MARK: - UI
	
	private let flexRootContainer = UIView()
	
	private let navigationBar = DesignSystem.MOITNavigationBar(
		leftItems: [.back],
		title: StringResource.navigationTitle.value,
		rightItems: []
	)
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = StringResource.title.value
		label.font = ResourceKitFontFamily.h4
		label.textColor = ResourceKitAsset.Color.gray900.color
		label.numberOfLines = 2
		return label
	}()
	
	// TODO: TextField title 옵셔널로 수정 필요
	private let codeTextField = MOITTextField(
		title: "",
		placeHolder: StringResource.placeHolder.value
	)
	
	private let joinMOITButton: UIButton = {
		let button = UIButton()
		button.setTitle(StringResource.buttonTitle.value, for: .normal)
		
		button.setTitleColor(CTAButtonResource.disabled.titleColor, for: .disabled)
		button.setTitleColor(CTAButtonResource.normal.titleColor, for: .normal)
		button.backgroundColor = CTAButtonResource.disabled.backgroundColor
		
		button.isEnabled = false
		return button
	}()
	
// MARK: - property
	
	private let disposeBag = DisposeBag()
	
// MARK: - override
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		configureView()
		configureLayout()
		bind()
	}
	
	public override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootContainer.pin.all(view.pin.safeArea)
		flexRootContainer.flex.layout()
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		activateFirstResponder()
		addKeyboardNotification()
	}
	
	public override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		deleteKeyboardNotification()
	}
	
// MARK: - private
	
	private func configureView() {
		view.backgroundColor = ResourceKitAsset.Color.white.color
		view.addSubview(flexRootContainer)
	}
	
	private func configureLayout() {
		flexRootContainer.flex.define { flex in
			flex.addItem(navigationBar)
			
			flex.addItem()
				.paddingTop(20)
				.paddingHorizontal(20)
				.define { flex in
					flex.addItem(titleLabel).marginBottom(60).height(64)
					flex.addItem(codeTextField)
			}
				.grow(1)
			
			flex.addItem(joinMOITButton).height(56)
		}
	}
	
	private func activateFirstResponder() {
		// ???: 이것보다 좋은 방법이 없을까...?
		codeTextField.textField.becomeFirstResponder()
	}
	
	private func addKeyboardNotification() {
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow),
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
	}
	
	private func deleteKeyboardNotification() {
		NotificationCenter.default.removeObserver(
			self,
			name: UIResponder.keyboardWillShowNotification,
			object: nil
		)
	}
	
	private func bind() {
		codeTextField.rx.text
			.map { $0.isEmpty }
			.subscribe(
				onNext: { [weak self] isEmpty in
					self?.joinMOITButton.isEnabled = !isEmpty
					self?.joinMOITButton.backgroundColor = isEmpty ? CTAButtonResource.disabled.backgroundColor : CTAButtonResource.normal.backgroundColor
				}
			)
			.disposed(by: disposeBag)
		
		joinMOITButton.rx.tap
			.subscribe(
				onNext: { [weak self] _ in
					self?.listener?.joinMOITButtonDidTap(code: "")
				}
			)
			.disposed(by: disposeBag)
	}
	
// MARK: - objc
	
	@objc private func keyboardWillShow(_ notification: Notification) {
		if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardHeight = keyboardFrame.cgRectValue.height - UIDevice.safeAreaBottomPadding

			joinMOITButton.flex.marginBottom(keyboardHeight)
			joinMOITButton.flex.markDirty()
			view.setNeedsLayout()
		}
	}
}

extension InputParticipateCodeViewController {
	private enum StringResource {
		case navigationTitle
		case title
		case placeHolder
		case buttonTitle
		
		var value: String {
			switch self {
			case .navigationTitle:
				return "스터디 참여하기"
			case .title:
				return "스터디 초대코드를\n입력해주세요"
			case .placeHolder:
				return "초대코드를 입력해주세요."
			case .buttonTitle:
				return "완료"
			}
		}
	}
	
	private enum CTAButtonResource {
		case disabled
		case normal
		
		var backgroundColor: UIColor {
			switch self {
			case .disabled:
				return ResourceKitAsset.Color.gray200.color
			case .normal:
				return ResourceKitAsset.Color.blue800.color
			}
		}

		var titleColor: UIColor {
			switch self {
			case .disabled:
				return ResourceKitAsset.Color.gray700.color
			case .normal:
				return ResourceKitAsset.Color.white.color
			}
		}
	}
}

extension UIDevice {
	static var safeAreaBottomPadding: CGFloat {
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
		   let window = windowScene.windows.first else {
			return 0
		}
		
		let bottomPadding = window.safeAreaInsets.bottom
		return bottomPadding
	}
}
