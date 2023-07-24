//
//  MOITDetailTab.swift
//  MOITDetail
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public enum MOITDetailTab {
    /// 출결
    case attendance
    /// 벌금
    case fine
    
    public var title: String {
        switch self {
        case .attendance: return "출결"
        case .fine: return "벌금"
        }
    }
}
