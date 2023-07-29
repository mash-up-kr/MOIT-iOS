//
//  ConvertAttendanceStatusUseCase.swift
//  MOITDetailDomain
//
//  Created by 최혜린 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import DesignSystem

public protocol ConvertAttendanceStatusUseCase {
	func execute(attendanceStatus: AttendanceStatus) -> MOITChipType
}
