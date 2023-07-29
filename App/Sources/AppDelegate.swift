//
//  AppDelegate.swift
//
//  MOIT
//
//  Created by 김찬수
//

import UIKit
import Firebase
import FirebaseMessaging
import RIBs

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
        
        let router = RootBuilder(dependency: EmptyComponent()).build()
        self.launchRouter = router
        window.rootViewController = UINavigationController(rootViewController: router.viewControllable.uiviewController)
        window.makeKeyAndVisible()

        router.interactable.activate()
        router.load()
        
        configure(application)
        return true
    }
    
    private func configure(_ application: UIApplication) {
        // 알림 등록
        requestAuthorization()
        // APNS에 디바이스 토큰 등록
        application.registerForRemoteNotifications()
        // firebase설정
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
    
    private func requestAuthorization() {
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [
          .alert,
          .badge,
          .sound
        ]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
    }
    
    // apns에 등록 후 토큰과 함께 콜백받음
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        // FCM에 토큰 설정
        Messaging.messaging().apnsToken = deviceToken
        let token = deviceToken.reduce("") {
                $0 + String(format: "%02X", $1)
            }
        print("🤖 apns callback token: ", token)
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        print("🤖open url: ", url)
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("🤖", response.notification.request.content.userInfo["url"])
        guard let url = response.notification.request.content.userInfo["url"] as? String,
                let type = DeepLinkType(rawValue: url) else { return }
        print(type)
    }
}

extension AppDelegate: MessagingDelegate {
    
}
