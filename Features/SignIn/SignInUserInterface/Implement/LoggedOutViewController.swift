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
}

public final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
	
// MARK: - UI

	// TODO: 디자인 확정 시 반영 필요
	private let flexRootContainer = UIView()
	
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
	
// MARK: - override
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		
		configureLayout()
	}
	
	override public func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootContainer.pin.all(view.pin.safeArea).marginHorizontal(20).marginBottom(48)
		flexRootContainer.flex.layout()
	}
	
// MARK: - private
	
	private func configureLayout() {
		view.backgroundColor = ResourceKitAsset.Color.blue100.color
		
		view.addSubview(flexRootContainer)
		
		flexRootContainer.flex.direction(.columnReverse).define { flex in
			flex.addItem(appleSignInButton).marginTop(12)
			flex.addItem(kakaoSignInButton)
		}
	}
}
