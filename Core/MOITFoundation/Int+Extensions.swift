//
//  Int+Extensions.swift
//  MOITFoundation
//
//  Created by 송서영 on 2023/06/18.
//

import Foundation

public extension Int {
    var toDecimalString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "KRW"
        numberFormatter.numberStyle = .currency
        return String(numberFormatter.string(for: self)?.dropFirst() ?? "0")
    }
}
