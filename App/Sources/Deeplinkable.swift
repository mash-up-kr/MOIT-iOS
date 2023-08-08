//
//  Deeplinkable.swift
//  App
//
//  Created by 송서영 on 2023/08/07.
//

import Foundation

protocol Deeplinkable: AnyObject {
    func routeToMOITList()
    func routeToDetail(id: String)
    func routeToAttendance(id: String)
    func routeToAttendanceResult(id: String)
    func routeToFine(moitID: String, fineID: String)
}
