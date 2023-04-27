//
//  AppComponent.swift
//
//  ModulariedSuperApp
//
//  Created by 김찬수
//

import Foundation
import RIBs

final class AppComponent: Component<EmptyDependency>, RootDependency {
  init() {
    super.init(dependency: EmptyComponent())
  }
}
