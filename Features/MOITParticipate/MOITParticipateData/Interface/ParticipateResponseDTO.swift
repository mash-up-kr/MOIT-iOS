//
//  ParticipateResponseDTO.swift
//  MOITParticipateData
//
//  Created by 최혜린 on 2023/08/04.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct ParticipateResponseDTO: Decodable {
	public let moitID: Int
	/// moit이름
	public let name: String
	/// moit 설명 (optional)
	public let description: String
	/// moit 이미지
	public let imageURL: String?
	/// moit 반복 요일
	public let scheduleDayOfWeeks: [String]
	/// moit 반복 주기
	public let scheduleRepeatCycle: String
	/// moit 시작 시간 (HH:mm)
	public let scheduleStartTime: String
	/// moit 종료 시간 (HH:mm)
	public let scheduleEndTime: String
	/// moit 지각 시간 (분)
	public let fineLateTime: Int
	/// moit 지각 벌금
	public let fineLateAmount: Int
	/// moit 결석 시간
	public let fineAbsenceTime: Int
	/// moit 결석 벌금
	public let fineAbsenceAmount: Int
	/// moit 알람 리마인드 on/off
	public let notificationIsRemindActive: Bool
	/// moit 알람 리마인드 시간
	public let notificationRemindOption: String?
	/// moit 시작 일자 (YYYY-MM-dd)
	public let startDate: String
	/// moit 종료 일자 (YYYY-MM-dd)
	public let endDate: String

	enum CodingKeys: String, CodingKey {
		case moitID = "moitId"
		case name
		case description
		case imageURL = "imageUrl"
		case scheduleDayOfWeeks
		case scheduleRepeatCycle
		case scheduleStartTime
		case scheduleEndTime
		case fineLateTime
		case fineLateAmount
		case fineAbsenceTime
		case fineAbsenceAmount
		case notificationIsRemindActive
		case notificationRemindOption
		case startDate
		case endDate
	}
}
