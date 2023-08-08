//
//  RootComponent.swift
//  App
//
//  Created by kimchansoo on 2023/08/06.
//

import Foundation

import RxSwift
import RxRelay
import RIBs

public final class AppComponent: Component<EmptyDependency>, AppDependency {
    
    public let fcmToken: PublishRelay<String>
    
    public init(fcmToken: PublishRelay<String>) {
        self.fcmToken = fcmToken
        super.init(dependency: EmptyComponent())
    }
    
}

protocol AppDependency: Dependency {
    var fcmToken: PublishRelay<String> { get }
}

