//
//  MOITTextField.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/06/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import FlexLayout
import PinLayout
import RxCocoa
import RxSwift

public final class MOITTextField: UIView {
	
	private let flexRootView = UIView()
	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 10
		return stackView
	}()
	private var titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = ResourceKitAsset.Color.gray700.color
		label.font = ResourceKitFontFamily.p2
		return label
	}()
	private var textField: UITextField = {
		let textField = UITextField()
		textField.layer.cornerRadius = 12
		textField.clipsToBounds = true
		textField.borderStyle = .roundedRect
		textField.layer.borderColor = ResourceKitAsset.Color.gray200.color.cgColor
		textField.backgroundColor = ResourceKitAsset.Color.gray50.color
		textField.font = ResourceKitFontFamily.p1
		textField.textColor = ResourceKitAsset.Color.black.color
		textField.tintColor = ResourceKitAsset.Color.black.color
		textField.addHorizontalPadding()
		return textField
	}()

	private let textFieldInputRelay = PublishRelay<String>()
	public var textFieldInput: Observable<String> {
		textFieldInputRelay.asObservable()
	}

	private let disposeBag = DisposeBag()
	private let title: String
	private let placeHolder: String

// MARK: - init
	public init(
		title: String,
		placeHolder: String
	) {
		self.title = title
		self.placeHolder = placeHolder

		super.init(frame: .zero)

		configureLayout()
		configureComponent()
		bind()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

// MARK: - override
	override public func layoutSubviews() {
		super.layoutSubviews()

		flexRootView.pin.all()
		flexRootView.pin.height(85)
		flexRootView.flex.layout()
	}

// MARK: - private func
	private func configureLayout() {
		self.addSubview(flexRootView)

		flexRootView.flex
			.direction(.column)
			.justifyContent(.spaceBetween)
			.define { flex in
				flex.addItem(titleLabel)
				flex.addItem(textField).height(53)
		 }
	}

	private func configureComponent() {
		titleLabel.text = title
		textField.attributedPlaceholder = NSAttributedString(
			string: placeHolder,
			attributes: [
				NSAttributedString.Key.foregroundColor: ResourceKitAsset.Color.gray500.color,
				NSAttributedString.Key.font: ResourceKitFontFamily.p1
			]
		)
	}

	private func bind() {
		textField.rx.text
			.orEmpty
			.bind(to: textFieldInputRelay)
			.disposed(by: disposeBag)
	}
}

// MARK: - UITextField Extension
extension UITextField {
	func addHorizontalPadding() {
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: self.frame.height))
		self.leftView = paddingView
		self.leftViewMode = ViewMode.always
		self.rightView = paddingView
		self.rightViewMode = ViewMode.always
	}
}