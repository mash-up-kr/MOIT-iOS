//
//  MOITWebViewController.swift
//  MOITWebImpl
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import UIKit
import WebKit

import CSLogger
import Utils
import DesignSystem
import TokenManagerImpl

import Toast
import RIBs
import RxSwift
import FirebaseMessaging

protocol MOITWebPresentableListener: AnyObject {
    func didSwipeBack()
	func notRegisteredMemeberDidSignIn(with headerFields: [AnyHashable: Any])
	func registeredMemberDidSignIn(with headerFields: [AnyHashable: Any])
    func didTapBackButton()
	func didTapErrorAlertOkButton()
    func didTapShare(with code: String)
}

final class MOITWebViewController: UIViewController,
                                   MOITWebPresentable,
                                   MOITWebViewControllable {
    
    private enum Constant {
        static let messageName = "MOIT"
    }
    
    weak var listener: MOITWebPresentableListener?
    private let contentViewcontroller = WKUserContentController()
    private var domain: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
		
		self.removeWKScriptMessageHandler(messageName: Self.Constant.messageName)
		
        if self.isMovingFromParent {
            self.listener?.didSwipeBack()
        }
    }
    
    deinit { debugPrint("\(self) deinit") }
}

// MARK: - MOITWebPresentable

extension MOITWebViewController {
    func render(domain: String, path: String) {
        guard let cookie = self.setCookie(path: path) else { return }
        let configuration = self.setWebConfiguration(with: cookie)
        let webView = WKWebView(frame: self.view.frame, configuration: configuration)
        webView.uiDelegate = self
		webView.navigationDelegate = self
        self.view.addSubview(webView)
//        if #available(iOS 16.4, *) {
//            webView.isInspectable = true
//        } 
        guard let url = URL(string: "\(domain)\(path)") else { return }
        let URLRequest = URLRequest(url: url)
        webView.load(URLRequest)
    }
}

// MARK: - Private functions

extension MOITWebViewController {
    
    private func setCookie(path: String) -> HTTPCookie? {
        HTTPCookie(properties: [
            .domain: "dev-moit-web.vercel.app",
            .path: path,
            .name: "accessToken",
            .value: "\(TokenManagerImpl().get(key: .authorizationToken) ?? "")"
        ])
    }
    
    private func setWebConfiguration(with cookie: HTTPCookie) -> WKWebViewConfiguration {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.isTextInteractionEnabled = true
        webConfiguration.websiteDataStore = .nonPersistent()
        webConfiguration.websiteDataStore.httpCookieStore.setCookie(cookie)
        
        let userContentViewController = self.setUserContentViewController(with: Self.Constant.messageName)
        webConfiguration.userContentController = userContentViewController
        
        return webConfiguration
    }
    
    private func setUserContentViewController(with messageName: String) -> WKUserContentController {
        self.contentViewcontroller.add(self, name: messageName)
        return contentViewcontroller
    }
    
    private func removeWKScriptMessageHandler(messageName: String) {
        self.contentViewcontroller.removeScriptMessageHandler(forName: messageName)
    }
}

// MARK: - WKScriptMessageHandler

enum Command: String {
    case toast
    case close
    case alert
    case share
    case didRegisterMOIT
}

extension MOITWebViewController: WKScriptMessageHandler {
    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        guard message.name == Constant.messageName,
            let messages = message.body as? [String: Any],
            let cmd = messages["command"] as? String,
            let command = Command(rawValue: cmd) else { return }
        
        print(cmd)
        print(command)
        print(messages["value"])
        switch command {
        case .close:
            didReceiveCloseCommand()
            
        case .alert:
           didReceiveAlertCommand(messages: messages)
            
        case .toast:
            didReceiveToastCommand(messages: messages)
            
        case .share:
            didReceiveShareCommand(messages: messages)
            
        case .didRegisterMOIT:
            didRegisterMOITCommand(messages: messages)
        }
    }
    
    private func didReceiveCloseCommand() {
        self.listener?.didTapBackButton()
    }
    
    private func didReceiveAlertCommand(messages: [String: Any]) {
        guard let value = messages["value"] as? String else { return }
        let alertController = UIAlertController(
            title: "타이틀",
            message: value,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    private func didReceiveToastCommand(messages: [String: Any]) {
        guard let value = messages["value"] as? String else { return }
        let toast = MOITToast(toastType: .success, text: value)
        self.view.showToast(toast, point: view.center)
    }
    
    private func didReceiveShareCommand(messages: [String: Any]) {
        var invitationCode = messages["value"] as? String ?? "전ㅈr군단"
        if invitationCode.isEmpty { invitationCode = "전ㅈr군단" }
        self.listener?.didTapShare(with: invitationCode)
    }
    
    private func didRegisterMOITCommand(messages: [String: Any]) {
        let moitID = messages["value"] as? Int ?? 0
        Messaging.messaging().subscribe(toTopic: "MOIT-\(moitID)") { error in
            print("register topic subscribe error is 👉", error)
        }
    }
}

// MARK: - WKUIDelegate

extension MOITWebViewController: WKUIDelegate {
}

// MARK: - WKNavigationDelegate

extension MOITWebViewController: WKNavigationDelegate {
	func webView(
		_ webView: WKWebView,
		decidePolicyFor navigationResponse: WKNavigationResponse,
		decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
	) {
		let currentPath = navigationResponse.response.url?.path() ?? ""
		let redirectURL = RedirectURL(pathRawValue: currentPath)
		
		switch redirectURL {
		case .signInSuccess:
			guard let response = navigationResponse.response as? HTTPURLResponse else { return decisionHandler(.allow) }
			
			let responsePolicy = executeResponseForSignIn(with: response)
			decisionHandler(responsePolicy)
		default:
			decisionHandler(.allow)
		}
	}
	
	private func executeResponseForSignIn(
		with response: HTTPURLResponse
	) -> WKNavigationResponsePolicy {
		
		Logger.debug(response.statusCode)
		
		let headerFields = response.allHeaderFields

		switch response.statusCode {
		case (200...299):
			listener?.registeredMemberDidSignIn(with: headerFields)
			return .allow
		case 401:
			listener?.notRegisteredMemeberDidSignIn(with: headerFields)
			return .cancel
		default:
			return .allow
		}
	}
}

// MARK: - presentable
extension MOITWebViewController {
	func showErrorAlert() {
		showAlert(
			message: StringResource.errorMessage.value,
			type: .single,
			okActionHandler: { [weak self] in
				self?.listener?.didTapErrorAlertOkButton()
			}
		)
	}
}

extension MOITWebViewController {
	enum RedirectURL: String {
		case none = ""
		case signInSuccess = "/api/v1/auth/sign-in/success"

		init(
			pathRawValue: String
		) {
			self = RedirectURL(rawValue: pathRawValue) ?? .none
		}
	}
}

extension MOITWebViewController {
	enum StringResource {
		case errorMessage
		
		var value: String {
			switch self {
			case .errorMessage:
				return "네트워크 에러가 발생했습니다. 다시 시도해주세요!"
			}
		}
	}
}
