//
//  NotPaidFineListView.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem
import ResourceKit

final class NotPaidFineListView: MOITList {
	var item: NotPaidFineListViewModel {
		self.fineViewModel
	}
	
	private let fineViewModel: NotPaidFineListViewModel
	
	private let button = MOITButton(
		type: .mini,
		title: "납부 인증하기",
		titleColor: ResourceKitAsset.Color.white.color,
		backgroundColor: ResourceKitAsset.Color.black.color
	)
	
	init(fineViewModel: NotPaidFineListViewModel) {
		self.fineViewModel = fineViewModel
		
		super.init(
			type: .sendMoney,
			title: fineViewModel.userNickName,
			detail: "\(fineViewModel.fineAmount)원",
			chipType: fineViewModel.chipType,
			studyOrder: fineViewModel.studyOrder,
			button: button
		)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
