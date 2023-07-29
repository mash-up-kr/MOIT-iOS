//
//  AuthorizePaymentViewModel.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem
import FineDomain

struct AuthorizePaymentViewModel {
	let isMaster: Bool
	let imageURL: String?
	let imageFile: UIImage?
	let fineID: Int
	/// 벌금 금액
	let fineAmount: String
	/// 지각, 결석
	let chipType: MOITChipType
	/// 벌금 미납자 이름
	let userNickName: String
	/// 스터디 n차
	let studyOrder: Int
	let buttonTitle: String?
	let approveStatus: FineApproveStatus
}
