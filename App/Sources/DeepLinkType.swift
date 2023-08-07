//
//  DeepLinkType.swift
//  App
//
//  Created by 송서영 on 2023/07/29.
//

import Foundation

/*
 홈: moit://home
 모잇상세 : moit://detail?moitId=\(id)
 벌급납부 : moit://fine?moidId=\(id)&fineId=\(id)
 출석하기 : moit://attendance?moitId=\(id)
 출석결과 : moit://attendanceResult?moitId=\(id)
 */
enum DeepLinkType: String {
    case home
    case detail
    case fine
    case attendance
    case attendanceResult
}
