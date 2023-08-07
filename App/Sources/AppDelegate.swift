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
import UserNotifications

@UIApplicationMain
final class AppDelegate: UIResponder,
                         UIApplicationDelegate {
    
    var window: UIWindow?
    private var launchRouter: LaunchRouting?
    private var builder: RootBuildable?
    private var deeplinkable: Deeplinkable?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let builder = RootBuilder(dependency: EmptyComponent())
        self.builder = builder
        let (router, interactor) = builder.build()
        self.launchRouter = router
        self.launchRouter?.launch(from: window)
        self.deeplinkable = interactor
        
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
        
        Messaging.messaging().subscribe(toTopic: "MOIT-80") { error in
          print("🤖 error", error)
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
        print("🤖", #function)
        guard let urlString = response.notification.request.content.userInfo["url"] as? String else { return }
              let path = String(urlString.split(separator: "://").last ?? "")
        
        guard let type = DeepLinkType(rawValue: path) else { return }
        
        switch type {
        case .home:
            self.deeplinkable?.routeToMOITList()
        case .detail:
            self.deeplinkable?.routeToDetail(id: "85")
        default: print("😲😲 DEEPLINK TYPE", type)
        }
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        print("🤖", #function)
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true) else { return false }
        guard let path = components.host else { return false }
        print(components)
        guard let type = DeepLinkType(rawValue: path) else { return false }
        print(type)
        
        switch type {
        case .home:
            self.deeplinkable?.routeToMOITList()
            
        case .detail:
            guard let query = components.query,
                  let id = query.split(separator: "=").last else { return false }
            self.deeplinkable?.routeToDetail(id: "\(id)")
            
        case .attendance:
            guard let query = components.query,
                  let id = query.split(separator: "=").last else { return false }
            self.deeplinkable?.routeToAttendance(id: "\(id)")
            
        case .attendanceResult:
            guard let query = components.query,
                  let id = query.split(separator: "=").last else { return false }
            self.deeplinkable?.routeToAttendanceResult(id: "\(id)")
            
        default: print("😲😲 DEEPLINK TYPE", type)
        }
        return true
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    // observing FCM token
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
      print("🤖 Firebase registration token observing: \(String(describing: fcmToken))")
    }
}

protocol Deeplinkable: AnyObject {
    func routeToMOITList()
    func routeToDetail(id: String)
    func routeToAttendance(id: String)
    func routeToAttendanceResult(id: String)
}
