//
//  Array+Extensions.swift
//  MOITFoundation
//
//  Created by 송서영 on 2023/07/04.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        if self.endIndex >= index { return self[index] }
        return nil
    }
}
