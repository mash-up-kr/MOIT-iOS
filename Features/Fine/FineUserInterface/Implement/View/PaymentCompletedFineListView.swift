//
//  PaymentCompletedFineListView.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import DesignSystem
import ResourceKit

final class PaymentCompletedFineListView: MOITList {
	var item: PaymentCompletedFineListViewModel {
		self.fineViewModel
	}
	
	private let fineViewModel: PaymentCompletedFineListViewModel

	init(fineViewModel: PaymentCompletedFineListViewModel) {
		self.fineViewModel = fineViewModel
		
		super.init(
			type: .myMoney,
			title: fineViewModel.useNickName,
			detail: "\(fineViewModel.approvedDate)원",
			chipType: fineViewModel.chipType,
			fine: fineViewModel.fineAmount
		)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
