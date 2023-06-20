//
//  AppDelegate.swift
//
//  MOIT
//
//  Created by 김찬수
//

import UIKit

import RIBs
import RxKakaoSDKCommon

@UIApplicationMain
final class AppDelegate: UIResponder,
                            UIApplicationDelegate {
    
    var window: UIWindow?
    private var launchRouter: LaunchRouting?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window
        else { return false }
		
		RxKakaoSDK.initSDK(appKey: "${NATIVE_APP_KEY}")
        
        let router = RootBuilder(dependency: EmptyComponent()).build()
        self.launchRouter = router
        self.launchRouter?.launch(from: window)
        return true
    }
}

