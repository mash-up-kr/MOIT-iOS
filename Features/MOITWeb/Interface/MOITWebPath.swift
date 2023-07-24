//
//  MOITWebPath.swift
//  MOITWeb
//
//  Created by 송서영 on 2023/05/25.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation

public enum MOITWebPath {
    case register
    case modify(id: String)
    case attendance
    case attendanceResult
    
    public var path: String {
        switch self {
        case .attendance: return "/attendance"
        case .register: return "/register"
        case .modify(let id): return "/register?id=\(id)"
        case .attendanceResult: return "/attendanceResult"
        }
    }
}
