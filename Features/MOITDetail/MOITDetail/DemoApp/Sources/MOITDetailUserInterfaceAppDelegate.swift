//
//  MOITDetailAppDelegate.swift
//
//  MOITDetail
//
//  Created by 송서영 on .
//

import UIKit
import MOITDetail
import MOITDetailImpl
import MOITNetworkImpl
import MOITNetwork
import RIBs

@main
final class MOITDetailAppDelegate: UIResponder,
                                   UIApplicationDelegate {
    final class MockMOITDetailDependency: MOITDetailDependency {
        var tabTypes: [MOITDetailTab] = [.attendance, .fine]
        var network: Network = NetworkImpl()
    }
    private final class MOCKMOITDetailListener: MOITDetailListener {
    }
    var window: UIWindow?
    private var router: ViewableRouting?
    let dependency = MockMOITDetailDependency()
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.router = MOITDetailBuilder(dependency: dependency)
            .build(withListener: MOCKMOITDetailListener(), moitID: "2")
        self.router?.load()
        self.router?.interactable.activate()
        window.rootViewController = self.router?.viewControllable.uiviewController
//        window.rootViewController = MOITDetailAttendanceViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
