//
//  MOITDetailModel.swift
//  MOITDetailData
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

// TODO: Decodable 채택 필요
public struct MOITDetailModel {
    public let moitID: String
    /// moit이름
    public let name: String
    /// moit장아이디
    public let masterID: String
    /// moit 설명 (optional)
    public let description: String
    /// moit 이미지
    public let imageURL: String
    /// moit 반복 요일
    public let scheduleDayOfWeek: [String]
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
    /// moit 시작 일자 (YYYY-MM-dd)
    public let startDate: String
    /// moit 종료 일자 (YYYY-MM-dd)
    public let endDate: String
    
    // 지우기 필요
    public init(moitID: String, name: String, masterID: String, description: String, imageURL: String, scheduleDayOfWeek: [String], scheduleRepeatCycle: String, scheduleStartTime: String, scheduleEndTime: String, fineLateTime: Int, fineLateAmount: Int, fineAbsenceTime: Int, fineAbsenceAmount: Int, startDate: String, endDate: String) {
        self.moitID = moitID
        self.name = name
        self.masterID = masterID
        self.description = description
        self.imageURL = imageURL
        self.scheduleDayOfWeek = scheduleDayOfWeek
        self.scheduleRepeatCycle = scheduleRepeatCycle
        self.scheduleStartTime = scheduleStartTime
        self.scheduleEndTime = scheduleEndTime
        self.fineLateTime = fineLateTime
        self.fineLateAmount = fineLateAmount
        self.fineAbsenceTime = fineAbsenceTime
        self.fineAbsenceAmount = fineAbsenceAmount
        self.startDate = startDate
        self.endDate = endDate
    }
    
    enum CodingKeys: String, CodingKey {
        case moitID = "moitId"
        case name
        case masterID = "masterId"
        case description
        case imageURL = "imageUrl"
        case scheduleDayOfWeek
        case scheduleRepeatCycle
        case scheduleStartTime
        case scheduleEndTime
        case fineLateTime
        case fineLateAmount
        case fineAbsenceTime
        case fineAbsenceAmount
        case startDate
        case endDate
    }
}
