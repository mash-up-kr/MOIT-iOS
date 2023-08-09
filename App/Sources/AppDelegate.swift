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
import UserNotifications
import TokenManagerImpl
import RxRelay
import Toast

@UIApplicationMain
final class AppDelegate: UIResponder,
                         UIApplicationDelegate {
    
    var window: UIWindow?
    private var launchRouter: LaunchRouting?
    private var builder: RootBuildable?
    var fcmToken = PublishRelay<String>()
    private var deeplinkable: Deeplinkable?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
		
		setToastStyle()
		
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        
        
        let builder = RootBuilder(
            dependency: AppComponent(fcmToken: self.fcmToken)
        )
        self.builder = builder
        let (router, interactor) = builder.build()
//        let router = builder?.build()
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

// MARK: - Private functions

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
                TokenManagerImpl().save(token: token, with: .fcmToken)
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
    
    @discardableResult
    func processDeeplink(query: String, type: DeepLinkType) -> Bool {
        switch type {
        case .home:
            self.deeplinkable?.routeToMOITList()
            
        case .details:
            guard let id = query.split(separator: "=").last else { return false }
            self.deeplinkable?.routeToDetail(id: "\(id)")
            
        case .attendance:
            guard let id = query.split(separator: "=").last else { return false }
            self.deeplinkable?.routeToAttendance(id: "\(id)")
            
        case .attendanceResult:
            guard let id = query.split(separator: "=").last else { return false }
            self.deeplinkable?.routeToAttendanceResult(id: "\(id)")
            
        case .fine:
            let params = query.split(separator: "&")
            let moitId = params.first?.split(separator: "=").last ?? ""
            let fineId = params.last?.split(separator: "=").last ?? ""
            
            self.deeplinkable?.routeToFine(moitID: "\(moitId)", fineID: "\(fineId)")
        }
        
        return true
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        guard let urlString = response.notification.request.content.userInfo["urlScheme"] as? String,
              let path = urlString.split(separator: "://").last?.split(separator: "?").first,
              let qeury = urlString.split(separator: "://").last?.split(separator: "?").last else { return }
        
        guard let type = DeepLinkType(rawValue: "\(path)") else { return }
        processDeeplink(query: "\(qeury)", type: type)
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        print("🤖", #function)
        guard let components = NSURLComponents(
            url: url,
            resolvingAgainstBaseURL: true
        ),
              let query = components.query,
              let path = components.host,
              let type = DeepLinkType(rawValue: path) else { return false }
        print(type, query)
        return processDeeplink(query: query, type: type)
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    // observing FCM token
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        guard let fcmToken else { return }
        TokenManagerImpl().save(token: fcmToken, with: .fcmToken)
        self.fcmToken.accept(fcmToken)
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
