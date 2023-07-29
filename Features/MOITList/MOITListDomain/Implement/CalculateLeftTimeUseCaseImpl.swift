//
//  CalculateLeftTimeUseCaseImpl.swift
//  MOITListDomain
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListDomain

public final class CalculateLeftTimeUseCaseImpl: CalculateLeftTimeUseCase {
    
    // MARK: - Initializers
    
    public init() {
        
    }
    
    // MARK: - Methods
    
    public func execute(startTime: Date, lateTime: Date, absenceTime: Date) -> Int {
        let currentTime = Date()

        if currentTime < startTime {
            return Int(startTime.timeIntervalSince(currentTime))
        }
        
        if currentTime >= startTime, lateTime > currentTime {
            return Int(lateTime.timeIntervalSince(currentTime))
        }
        
        if currentTime >= lateTime, absenceTime > currentTime {
            return Int(absenceTime.timeIntervalSince(currentTime))
        }

        return 0
    }

}
