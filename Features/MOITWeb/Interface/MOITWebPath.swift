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
    case attendance(id: String, keyboardHeight: CGFloat)
    case attendanceResult(id: String)
    
	case signIn
    
    case 개인정보처리방침
    case 서비스이용약관
    
    public var path: String {
        switch self {
        case let .attendance(id, keyboardHeight): return "/attendance?studyId=\(id)&keyboardHeight=\(keyboardHeight)"
        case .register: return "/register"
        case .modify(let id): return "/register?studyId=\(id)"
        case .attendanceResult(let id): return "/attendanceResult?studyId=\(id)"
		case .signIn: return "/api/v1/auth/sign-in"
        case .개인정보처리방침: return "/3d5044b71c9c4b1c887706c9d9e6ffc4"
        case .서비스이용약관: return "/3d5044b71c9c4b1c887706c9d9e6ffc4"
        }
    }
}
