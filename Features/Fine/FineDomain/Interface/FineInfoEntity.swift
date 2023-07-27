//
//  FineInfoEntity.swift
//  FineDomain
//
//  Created by 최혜린 on 2023/07/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITDetailDomain
import FineData

// MARK: - FineInfo
public struct FineInfoEntity {
	public let totalFineAmount: Int
	public let notPaidFineList, paymentCompletedFineList: FineListEntity
	
	public init(fineInfo: FineInfo) {
		self.totalFineAmount = fineInfo.totalFineAmount
		self.notPaidFineList = fineInfo.notPaidFineList.map { FineItemEntity(fineItem: $0) }
		self.paymentCompletedFineList = fineInfo.paymentCompletedFineList.map { FineItemEntity(fineItem: $0) }
	}
	
	public init(
		totalFineAmount: Int,
		notPaidFineList: FineListEntity,
		paymentCompletedFineList: FineListEntity
	) {
		self.totalFineAmount = totalFineAmount
		self.notPaidFineList = notPaidFineList
		self.paymentCompletedFineList = paymentCompletedFineList
	}
}

public typealias FineListEntity = [FineItemEntity]

// MARK: - Fine
public struct FineItemEntity {
	public let id, fineAmount, userID: Int
	public let userNickname: String
	public let attendanceStatus: AttendanceStatus
	public let studyOrder: Int
	public let isApproved: Bool
	public let approveAt: String
	
	public init(fineItem: FineItem) {
		self.id = fineItem.id
		self.fineAmount = fineItem.fineAmount
		self.userID = fineItem.userID
		self.userNickname = fineItem.userNickname
		self.attendanceStatus = AttendanceStatus(fromRawValue: fineItem.attendanceStatus)
		self.studyOrder = fineItem.studyOrder + 1
		self.isApproved = fineItem.isApproved
		self.approveAt = fineItem.approveAt
	}
	
	public init(
		id: Int,
		fineAmount: Int,
		userID: Int,
		userNickname: String,
		attendanceStatus: AttendanceStatus,
		studyOrder: Int,
		isApproved: Bool,
		approveAt: String
	) {
		self.id = id
		self.fineAmount = fineAmount
		self.userID = userID
		self.userNickname = userNickname
		self.attendanceStatus = attendanceStatus
		self.studyOrder = studyOrder
		self.isApproved = isApproved
		self.approveAt = approveAt
	}
}
