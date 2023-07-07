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

// MARK: - UI
	
	private let flexRootView = UIView()
	
	private lazy var titleLabel: UILabel? = {
		if let title {
			let label = UILabel()
			label.textColor = ResourceKitAsset.Color.gray700.color
			label.font = ResourceKitFontFamily.p2
			label.text = title
			return label
		}
		
		return nil
	}()
	
	fileprivate var textField: UITextField = {
		let textField = UITextField()
		textField.layer.cornerRadius = 12
		textField.clipsToBounds = true
		textField.layer.borderColor = ResourceKitAsset.Color.gray200.color.cgColor
		textField.layer.borderWidth = 1
		textField.backgroundColor = ResourceKitAsset.Color.gray50.color
		textField.font = ResourceKitFontFamily.p1
		textField.textColor = ResourceKitAsset.Color.black.color
		textField.tintColor = ResourceKitAsset.Color.black.color
		textField.addHorizontalPadding()
		return textField
	}()
	
// MARK: - property

	private let disposeBag = DisposeBag()
	private let title: String?
	private let placeHolder: String

// MARK: - init
	
	public init(
		title: String?,
		placeHolder: String
	) {
		self.title = title
		self.placeHolder = placeHolder

		super.init(frame: .zero)

		configureLayout()
		configureComponent()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

// MARK: - override
	override public func layoutSubviews() {
		super.layoutSubviews()

		flexRootView.pin.all()
		flexRootView.flex.layout()
	}

// MARK: - private func

	private func configureLayout() {
		self.addSubview(flexRootView)

		flexRootView.flex
			.direction(.column)
			.define { flex in
				
				flex.addOptionalItem(titleLabel, height: 22, marginBottom: 10)
				
				flex.addItem(textField).height(53)
		 }
	}

	private func configureComponent() {
		textField.attributedPlaceholder = NSAttributedString(
			string: placeHolder,
			attributes: [
				NSAttributedString.Key.foregroundColor: ResourceKitAsset.Color.gray500.color,
				NSAttributedString.Key.font: ResourceKitFontFamily.p1
			]
		)
	}
	
// MARK: - public
	
	public func textFieldBecomeFirstResponse() {
		textField.becomeFirstResponder()
	}
	
	public var text: String {
		textField.text ?? ""
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

// MARK: - Reactive
extension Reactive where Base: MOITTextField {
	public var text: Observable<String> {
		base.textField.rx.text.orEmpty.asObservable()
	}
 }
