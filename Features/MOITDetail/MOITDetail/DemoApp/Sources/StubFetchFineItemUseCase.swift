//
//  StubFetchFineItemUseCase.swift
//  MOITDetailDemoApp
//
//  Created by 최혜린 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import FineDomain

import RxSwift

final class StubFetchFineItemUseCase: FetchFineItemUseCase {
	func execute(
		moitID: Int,
		fineID: Int
	) -> Single<FineItemEntity> {
		.just(
			FineItemEntity(id: 0,
			fineAmount: 1000,
			userID: 0,
			userNickname: "가가가",
						   attendanceStatus: .ABSENCE,
			studyOrder: 1,
			approveAt: "",
			fineApproveStatus: .inProgress,
			imageURL: "")
		)
	}
}
