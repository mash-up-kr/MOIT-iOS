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

import RxSwift

final class NotPaidFineListView: MOITList {
	var item: NotPaidFineListViewModel {
		self.fineViewModel
	}
	
	fileprivate let fineViewModel: NotPaidFineListViewModel
	
	private let button: MOITButton?
	
	init(fineViewModel: NotPaidFineListViewModel) {
		self.fineViewModel = fineViewModel
		
		if let title = fineViewModel.buttonTitle,
		   let bgColor = fineViewModel.buttonBackgroundColor,
		   let titleColor = fineViewModel.buttonTitleColor {
			
			self.button = MOITButton(
				type: .mini,
				title: title,
				titleColor: titleColor,
				backgroundColor: bgColor
			)
		} else {
			self.button = nil
		}
		
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

extension Reactive where Base: NotPaidFineListView {
	var tappedFineID: Observable<Int> {
		return self.base.rx.tap
			.compactMap { _ -> Int in
				self.base.fineViewModel.fineID
			}
	}
}
