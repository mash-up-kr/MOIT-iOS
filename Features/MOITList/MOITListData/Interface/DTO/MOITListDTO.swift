//
//  MOITListDTO.swift
//  MOITListData
//
//  Created by kimchansoo on 2023/07/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListDomain

public struct MOITListDTO: Decodable {
    public let moits: [MOITDTO]
}

public extension MOITListDTO {
    
    struct MOITDTO: Decodable {
        let id: Int
        let name: String
        let profileUrl: String?
        let isEnd: Bool
        let repeatCycle: String
        let dayOfWeeks: [String]
        let startTime: String
        let endTime: String
        let dday: Int?
        
        public func toMOIT() -> MOIT {
            MOIT(
                id: self.id,
                name: self.name,
                profileUrl: self.profileUrl,
                isEnd: self.isEnd,
                repeatCycle: self.repeatCycle,
                dayOfWeeks: self.dayOfWeeks,
                startTime: self.startTime,
                endTime: self.endTime,
                dday: self.dday ?? 0
            )
        }
    }
}
