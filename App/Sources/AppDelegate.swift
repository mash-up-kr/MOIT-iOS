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
    
    // apns에 등록 후 토큰과 함께 콜백받음
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        // FCM에 토큰 설정
        Messaging.messaging().apnsToken = deviceToken
        getFCMToken()
    }
}

private extension AppDelegate {
    func requestAuthorization() {
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
    
    func apnsToken(_ token: Data) {
        let token = token.reduce("") {
                $0 + String(format: "%02X", $1)
            }
        print("🤖 apns callback token: ", token)
    }
    
    func getFCMToken() {
        Messaging.messaging().token { token, error in
          if let error = error {
            print("🤖 Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("🤖 FCM registration token: \(token)")
          }
        }
    }
    
    func configure(_ application: UIApplication) {
        // 알림 등록
        requestAuthorization()
        // APNS에 디바이스 토큰 등록
        application.registerForRemoteNotifications()
        // firebase설정
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        guard let urlString = response.notification.request.content.userInfo["url"] as? String else { return }
              let path = String(urlString.split(separator: "://").last ?? "")
        
        guard let type = DeepLinkType(rawValue: path) else { return }
        
        // TODO: type에 따라 이동하는 로직 필요
        switch type {
        default: print(type)
        }
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    // observing FCM token
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
      print("Firebase registration token: \(String(describing: fcmToken))")
    }
}
