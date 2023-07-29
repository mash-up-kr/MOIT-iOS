//
//  FineListViewModel.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/07/27.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import DesignSystem

struct FineInfoViewModel {
	let totalFineAmountText: String
	let myNotPaidFineListViewModel: [NotPaidFineListViewModel]
	let othersNotPaidFineListViewModel: [NotPaidFineListViewModel]
	let paymentCompletedFineListViewModel: [PaymentCompletedFineListViewModel]
	
	init(
		totalFineAmountText: String,
		myNotPaidFineListViewModel: [NotPaidFineListViewModel],
		othersNotPaidFineListViewModel: [NotPaidFineListViewModel],
		paymentCompletedFineListViewModel: [PaymentCompletedFineListViewModel]
	) {
		self.totalFineAmountText = totalFineAmountText
		self.myNotPaidFineListViewModel = myNotPaidFineListViewModel
		self.othersNotPaidFineListViewModel = othersNotPaidFineListViewModel
		self.paymentCompletedFineListViewModel = paymentCompletedFineListViewModel
	}
}

/// 스터디원 벌금 미납자 리스트 viewmodel
struct NotPaidFineListViewModel {
	/// 벌금 id
	let fineID: Int
	/// 벌금 금액
	let fineAmount: Int
	/// 지각, 결석
	let chipType: MOITChipType
	/// 내 벌금인지 여부(버튼 표시 여부)
	let isMyFine: Bool
	/// 벌금 미납자 이름
	let useNickName: String
	/// 스터디 n차
	let studyOrder: Int
	/// 벌금 이미지 url
	let imageURL: String?
	/// 버튼 타이틀
	let buttonTitle: String?
}

struct PaymentCompletedFineListViewModel {
	/// 벌금 금액
	let fineAmount: Int
	/// 지각, 결석
	let chipType: MOITChipType
	/// 벌금 미납자 이름
	let useNickName: String
	/// 인증 시간
	let approvedDate: String
}
