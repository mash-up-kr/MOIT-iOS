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
		
		if fineID == 0 {
			return .just(
				FineItemEntity(id: 0,
			 fineAmount: 1000,
			 userID: 0,
			 userNickname: "가가가",
			 attendanceStatus: .ABSENCE,
			 studyOrder: 1,
			 approveAt: "",
			 fineApproveStatus: .inProgress,
			 imageURL: "https://i.namu.wiki/i/VqjJvDAfZMnz-gt-Tek9kLmlLoAn0hXQpcqw5X-AYdNXcTAOSPcksUrF-0RCJbNnuyAYhNYJaluRPV9EWVGx1A.webp")
		 )
		} else {
			return .just(
				FineItemEntity(id: 1,
				fineAmount: 2000,
				userID: 0,
				userNickname: "가가가",
				attendanceStatus: .LATE,
				studyOrder: 2,
				approveAt: "",
				fineApproveStatus: .new,
				imageURL: "")
			)
		}
	}
}
