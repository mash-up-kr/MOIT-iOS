//
//  ConvertAttendanceStatusUseCaseImpl.swift
//  MOITDetailDomainImpl
//
//  Created by 최혜린 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITDetailDomain
import DesignSystem

public final class ConvertAttendanceStatusUseCaseImpl: ConvertAttendanceStatusUseCase {
	
	public init() { }
	
	public func execute(attendanceStatus: AttendanceStatus) -> MOITChipType {
		switch attendanceStatus {
			case .LATE:
				return .late
			case .ABSENCE:
				return .absent
			default:
				return .absent
		}
	}
}
