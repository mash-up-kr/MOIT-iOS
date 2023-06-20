//
//  StudyInfoCardDemoViewController.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem

import FlexLayout

final class StudyInfoCardDemoViewController: UIViewController {
	
	private let flexRootContainer = UIView()
	
	private let infoCard = MOITStudyInfoCard()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(flexRootContainer)
		view.backgroundColor = . white
		
		addLists()
		
		infoCard.configure(
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
		
		infoCard.flex.markDirty()
		view.setNeedsLayout()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootContainer.pin.all(view.pin.safeArea)
		flexRootContainer.flex.layout()
	}

	private func addLists() {
		self.flexRootContainer.flex.define { (flex) in
			
			flex.addItem(infoCard)
				.margin(10)
		}
	}
}
