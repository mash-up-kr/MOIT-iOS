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
    public let executeDeepLink: PublishRelay<String>
    
    public init(
        fcmToken: PublishRelay<String>,
        executeDeepLink: PublishRelay<String>
    ) {
        self.executeDeepLink = executeDeepLink
        self.fcmToken = fcmToken
        super.init(dependency: EmptyComponent())
    }
    
}

protocol AppDependency: Dependency {
    var fcmToken: PublishRelay<String> { get }
    var executeDeepLink: PublishRelay<String> { get }
}

