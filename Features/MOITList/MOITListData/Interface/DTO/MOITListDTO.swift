//
//  MOITListDTO.swift
//  MOITListData
//
//  Created by kimchansoo on 2023/07/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOITListDTO: Decodable {
    let moits: [MOITDTO]
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
        let dday: Int
    }
}
