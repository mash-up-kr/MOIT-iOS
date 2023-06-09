//
//  MOITListDemoViewController.swift
//  DesignSystem
//
//  Created by 최혜린 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem
import ResourceKit

import FlexLayout
import RxCocoa
import RxSwift

final class MOITListDemoViewController: UIViewController {
	
	private let flexRootContainer = UIView()
	private let buttonTapEventLabel: UILabel = {
		let label = UILabel()
		label.text = "0번 탭 됐음!"
		return label
	}()
	
	private let disposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(flexRootContainer)
		view.backgroundColor = . white
		
		addLists()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		flexRootContainer.pin.all(view.pin.safeArea)
		flexRootContainer.flex.layout()
	}

	private func addLists() {
		self.flexRootContainer.flex.define { (flex) in
			
			flex.addItem(allAttendList())
				.margin(10)
			
			flex.addItem(myAttendList())
				.margin(10)
			
			flex.addItem(buttonTapEventLabel).height(20)
				.margin(10)
			
			flex.addItem(sendMoneyList())
				.margin(10)
			
			flex.addItem(sendMoneyListWithoutButton())
				.margin(10)
			
			flex.addItem(myMoneyList())
				.margin(10)
			
			flex.addItem(peopleList())
				.margin(10)
		}
	}
	
	private func allAttendList() -> MOITList {
		MOITList(
			type: .allAttend,
			image: DesignSystemDemoAppAsset.profileImage.image,
			title: "가나다라마바사아자차카타",
			detail: "17:02",
			chipType: .attend
		)
	}
	
	private func myAttendList() -> MOITList {
		MOITList(
			type: .myAttend,
			title: "1차 스터디",
			detail: "2023.04.21 17:02",
			chipType: .late
		)
	}
	
	private func sendMoneyList() -> MOITList {
		let sendMoneyList = MOITList(
			type: .sendMoney,
			image: DesignSystemDemoAppAsset.profileImage.image,
			title: "가나다라마바사아자차카타",
			detail: "15,000원",
			button: MOITButton(
				type: .mini,
				title: "납부 인증하기",
				titleColor: ResourceKitAsset.Color.white.color,
				backgroundColor: ResourceKitAsset.Color.gray900.color
			)
		)
		
		var tapEventCount = 0
		
		sendMoneyList.rx.tap
			.subscribe(
				onNext: { [weak self] _ in
					guard let self else { return }
					tapEventCount += 1
					self.buttonTapEventLabel.text = "\(tapEventCount)번 탭 됐음!"
				}
			)
			.disposed(by: disposeBag)
		
		return sendMoneyList
	}
	
	private func sendMoneyListWithoutButton() -> MOITList {
		MOITList(
			type: .sendMoney,
			image: DesignSystemDemoAppAsset.profileImage.image,
			title: "가나다라마바사아자차카타",
			detail: "15,000원"
		)
	}
	
	private func myMoneyList() -> MOITList {
		MOITList(
			type: .myMoney,
			title: "3차스터디",
			detail: "2023.04.21 17:02",
			chipType: .late,
			fine: "+ 12,000원"
		)
	}
	
	private func peopleList() -> MOITList {
		MOITList(
			type: .people,
			image:DesignSystemDemoAppAsset.profileImage.image,
			title: "가나다라마바사아자차카타"
		)
	}
}
