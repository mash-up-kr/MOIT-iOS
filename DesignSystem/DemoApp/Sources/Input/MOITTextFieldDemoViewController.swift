//
//  MOITTextFieldDemoViewController.swift
//  DesignSystemDemoApp
//
//  Created by 최혜린 on 2023/06/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem

import RxCocoa
import RxSwift

final class MOITTextFieldDemoViewController: UIViewController {

	private let flexRootView = UIView()
	private let emptyTextField = MOITTextField(
		title: "emptyTextField",
		placeHolder: "비어있는 텍스트 필드 테스트입니다"
	)
	private let label = UILabel()
	
	private let noTitleTextField = MOITTextField(
		title: nil,
		placeHolder: "제목이 없는 텍스트 필드 테스트입니다."
	)

	private let disposeBag = DisposeBag()

// MARK: - override
	override func viewDidLoad() {
		super.viewDidLoad()

		configureLayout()
		bind()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		flexRootView.pin.all(view.pin.safeArea)
		flexRootView.flex.layout(mode: .adjustHeight)
	}

// MARK: - private func
	private func configureLayout() {
		view.backgroundColor = .white
		view.addSubview(flexRootView)
		flexRootView.flex
			.margin(20)
			.direction(.column)
			.define { flex in
				flex.addItem(emptyTextField)
				flex.addItem(label).height(20).marginTop(30)
				flex.addItem(noTitleTextField).marginTop(30)
			}
	}

	private func bind() {
		emptyTextField.rx.text
			.bind(to: label.rx.text)
			.disposed(by: disposeBag)
	}
}
