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

import RIBs
import RxSwift

protocol MOITWebPresentableListener: AnyObject {
    func didSwipeBack()
	func notRegisteredMemeberDidSignIn(with headerFields: [AnyHashable: Any])
	func registeredMemberDidSignIn(with headerFields: [AnyHashable: Any])
    func didTapBackButton()
	func didTapErrorAlertOkButton()
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
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
        self.view.addSubview(webView)

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
            .value: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqd3QtdXNlci1kZWZhdWx0IiwiYXVkIjoiYXV0aDB8YWJjQG5hdmVyLmNvbXw3fGRlZmF1bHQiLCJpc3MiOiJodHRwczovL2dpdGh1Yi5jb20vbWFzaC11cC1rci9NT0lULWJhY2tlbmQiLCJpYXQiOjE2ODg4ODkyOTMsImV4cCI6MTY5MTQ4MTI5MywiaW5mbyI6eyJpZCI6NywicHJvdmlkZXJVbmlxdWVLZXkiOiJhdXRoMHxhYmNAbmF2ZXIuY29tIiwibmlja25hbWUiOiJkZWZhdWx0IiwicHJvZmlsZUltYWdlIjowLCJlbWFpbCI6ImFiY0BuYXZlci5jb20iLCJyb2xlcyI6WyJVU0VSIl19fQ.o9WjiGqNOZSkHGDKQ54b50TUEy-oWvPo1-5Egjw1HXc"
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
    case keypad
    case share
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
        
        switch command {
        case .close:
            self.listener?.didTapBackButton()
        default:
            let value = messages["body"]
            let alertController = UIAlertController(
                title: "\(cmd)",
                message: "\(value)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
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
