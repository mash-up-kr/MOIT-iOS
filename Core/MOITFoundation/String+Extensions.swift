//
//  String+Extensions.swift
//  MOITFoundation
//
//  Created by 송서영 on 2023/06/18.
//

import Foundation

public extension String {
    var dateKORString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(for: convertDate) ?? ""
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(for: convertDate) ?? ""
    }
}
