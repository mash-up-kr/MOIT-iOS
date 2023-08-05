//
//  MOITPreviewViewModel.swift
//  MOITListUserInterface
//
//  Created by kimchansoo on 2023/07/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListDomain

public struct MOITPreviewViewModel {
    let remainingDate: Int
    let profileUrlString: String?
    let studyName: String
    var studyProgressDescription: String?
    
    public init(
        remainingDate: Int,
        profileUrlString: String?,
        studyName: String,
        studyProgressDescription: String?
    ) {
        self.remainingDate = remainingDate
        self.profileUrlString = profileUrlString
        self.studyName = studyName
        self.studyProgressDescription = studyProgressDescription
    }
    
    public init(moit: MOIT) {
        self.remainingDate = moit.dday
        self.profileUrlString = moit.profileUrl
        self.studyName = moit.name
        self.studyProgressDescription = makeStudyProgressDescription(moit: moit)
    }
    
    private func makeStudyProgressDescription(moit: MOIT) -> String {
        // 시간 포맷 hh:mm:ss -> hh:mm
        let startTime = removeSeconds(fromTimeString: moit.startTime) ?? moit.startTime
        let endTime = removeSeconds(fromTimeString: moit.endTime) ?? moit.endTime
        
        let repeatCycleDescription = makeRepeatCycleDescription(repeatCycle: moit.repeatCycle)
        let dayOfWeeksDescription = makeDayOfWeeksDescription(dayOfWeeks: moit.dayOfWeeks)
        return "\(repeatCycleDescription) \(dayOfWeeksDescription) \(startTime) - \(endTime)"
    }
    
    private func makeDayOfWeeksDescription(dayOfWeeks: [DayOfWeek]) -> String {
        guard !dayOfWeeks.isEmpty else {
            return ""
        }
        
        let dayOfWeeksDescription = dayOfWeeks.map { dayOfWeek in
            switch dayOfWeek {
            case .monday:
                return "월요일"
            case .tuesday:
                return "화요일"
            case .wednesday:
                return "수요일"
            case .thursday:
                return "목요일"
            case .friday:
                return "금요일"
            case .saturday:
                return "토요일"
            case .sunday:
                return "일요일"
            }
        }
        return dayOfWeeksDescription.joined(separator: ", ")
    }
    
    
    private func makeRepeatCycleDescription(repeatCycle: RepeatCycle) -> String {
        switch repeatCycle {
        case .none:
            return ""
        case .oneWeek:
            return "매주"
        case .twoWeek:
            return "2주마다"
        case .threeWeek:
            return "3주마다"
        case .fourWeek:
            return "4주마다"
        }
    }
    
    func removeSeconds(fromTimeString timeString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "HH:mm:ss"
        
        if let date = inputFormatter.date(from: timeString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
