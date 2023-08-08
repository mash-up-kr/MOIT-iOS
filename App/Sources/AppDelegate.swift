//
//  AppDelegate.swift
//
//  MOIT
//
//  Created by 김찬수
//

import UIKit
import UserNotifications

import ResourceKit

import Firebase
import FirebaseMessaging
import RIBs
import Toast

@UIApplicationMain
final class AppDelegate: UIResponder,
                         UIApplicationDelegate {
    
    var window: UIWindow?
    private var launchRouter: LaunchRouting?
    private var builder: RootBuildable?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
		
		setToastStyle()
		
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        self.builder = RootBuilder(dependency: EmptyComponent())
        let router = builder?.build()
        self.launchRouter = router
        self.launchRouter?.launch(from: window)
        
        self.configure(application)
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

extension AppDelegate {
	private func setToastStyle() {
		var style = ToastStyle()
		style.backgroundColor = ResourceKitAsset.Color.gray800.color
		style.cornerRadius = 10
		style.imageSize = CGSize(width: 24, height: 24)
		style.verticalPadding = 20
		style.messageFont = ResourceKitFontFamily.p2
		ToastManager.shared.style = style
		ToastManager.shared.duration = 5.0
	}
}
