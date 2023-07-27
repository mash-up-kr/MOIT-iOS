//
//  FineListViewModel.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/07/27.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import DesignSystem

/// 스터디원 벌금 미납자 리스트 viewmodel
// TODO: image URL 프로퍼티 추가 요청해야함
struct ParticipantNotPaidFineListViewModel {
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
	/// 인증 여부(납부 인증하기/인증 대기 중)
	let isApproved: Bool
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

struct ParticipantFineInfoViewModel {
	let totalFineAmount: Int
	let notPaidFineList: [ParticipantFineInfoViewModel]
	let paymentCompletedFineList: [PaymentCompletedFineListViewModel]
}
