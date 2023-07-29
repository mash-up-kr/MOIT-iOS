//
//  StubFetchFineInfoUseCase.swift
//  MOITDetailDemoApp
//
//  Created by 최혜린 on 2023/07/27.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import FineDomain

import RxSwift

final class StubFetchFineInfoUseCase: FetchFineInfoUseCase {
	func execute(moitID: String) -> Single<FineInfoEntity> {
		.just(
			FineInfoEntity(
				totalFineAmount: 5000,
				notPaidFineList: [
					FineItemEntity(
						id: 0,
						fineAmount: 1000,
						userID: 0,
						userNickname: "가가가",
						attendanceStatus: .ABSENCE,
						studyOrder: 1,
						approveAt: "2023.07.29",
						fineApproveStatus: .new,
						imageURL: ""
					),
					FineItemEntity(
						id: 1,
						fineAmount: 2000,
						userID: 1,
						userNickname: "나나나",
						attendanceStatus: .LATE,
						studyOrder: 2,
						approveAt: "2023.07.29",
						fineApproveStatus: .new,
						imageURL: ""
					),
					FineItemEntity(
						id: 2,
						fineAmount: 3000,
						userID: 2,
						userNickname: "다다다",
						attendanceStatus: .LATE,
						studyOrder: 3,
						approveAt: "2023.07.29",
						fineApproveStatus: .new,
						imageURL: ""
					)
				],
				paymentCompletedFineList: [
					FineItemEntity(
						id: 0,
						fineAmount: 1000,
						userID: 0,
						userNickname: "가가가",
						attendanceStatus: .ABSENCE,
						studyOrder: 1,
						approveAt: "2023.07.29",
						fineApproveStatus: .new,
						imageURL: ""
					),
					FineItemEntity(
						id: 1,
						fineAmount: 2000,
						userID: 1,
						userNickname: "나나나",
						attendanceStatus: .LATE,
						studyOrder: 2,
						approveAt: "2023.07.29",
						fineApproveStatus: .new,
						imageURL: ""
					),
					FineItemEntity(
						id: 2,
						fineAmount: 3000,
						userID: 2,
						userNickname: "다다다",
						attendanceStatus: .LATE,
						studyOrder: 3,
						approveAt: "2023.07.29",
						fineApproveStatus: .new,
						imageURL: ""
					)
				]
			)
		)
	}
}
