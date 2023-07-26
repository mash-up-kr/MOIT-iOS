//
//  FineInfo.swift
//  FineData
//
//  Created by 최혜린 on 2023/07/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

// MARK: - FineInfo
public struct FineInfo: Codable {
	public let totalFineAmount: Int
	public let notPaidFineList, paymentCompletedFineList: FineList
	
	public enum CodingKeys: String, CodingKey {
		case totalFineAmount
		case notPaidFineList = "fineNotYet"
		case paymentCompletedFineList = "fineComplete"
	}
}

public typealias FineList = [FineItem]

// MARK: - Fine
public struct FineItem: Codable {
	public let id, fineAmount, userID: Int
	public let userNickname, attendanceStatus: String
	public let studyOrder: Int
	public let isApproved: Bool
	public let approveAt: String

	public enum CodingKeys: String, CodingKey {
		case id, fineAmount
		case userID = "userId"
		case userNickname, attendanceStatus, studyOrder, isApproved, approveAt
	}
}
