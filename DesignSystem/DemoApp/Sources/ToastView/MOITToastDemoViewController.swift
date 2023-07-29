//
//  MOITToastDemoViewController.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/07/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit
import DesignSystem

import PinLayout
import FlexLayout

final class MOITToastDemoViewController: UIViewController {
	
	private let flexRootView = UIView()
	private let successToastView = MOITToast(
		toastType: .success,
		text: "성공시 사용됩니다."
	)
	private let failToastView = MOITToast(
		toastType: .fail,
		text: "실패시 사용됩니다."
	)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(flexRootView)
		view.backgroundColor = .white
		
		configureLayout()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootView.pin.all(view.pin.safeArea)
		flexRootView.flex.layout()
	}
	
	private func configureLayout() {
		flexRootView.flex.define { flex in
			flex.addItem(successToastView)
			flex.addItem(failToastView).marginTop(20)
		}
	}
}
