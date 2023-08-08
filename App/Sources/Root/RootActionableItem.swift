//
//  RootActionableItem.swift
//  App
//
//  Created by 송서영 on 2023/08/06.
//

import Foundation
import RxSwift
import MOITListUserInterface

public protocol RootActionableItem: AnyObject {
    func waitForLogin() -> Observable<(RootActionableItem, ())>
    func routeToMOITList() -> Observable<(MOITListActionableItem, ())>
}
