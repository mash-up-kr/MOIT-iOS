//
//  MOITWebViewController.swift
//  MOITWebImpl
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import UIKit
import WebKit

import RIBs
import RxSwift

protocol MOITWebPresentableListener: AnyObject {
    func didSwipeBack()
	func notRegisteredMemeberDidSignIn(with headerFields: [AnyHashable: Any])
	func registeredMemberDidSignIn(with token: String)
}

final class MOITWebViewController: UIViewController,
                                   MOITWebPresentable,
                                   MOITWebViewControllable {
    
    private enum Constant {
        static let messageName = "MOIT"
        
        // TODO: 합의 후 수정 필요
        static let domain = "http://moit-backend-eb-env.eba-qtcnkjjy.ap-northeast-2.elasticbeanstalk.com/api/v1/"
    }
    
    weak var listener: MOITWebPresentableListener?
    private let contentViewcontroller = WKUserContentController()
    
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
    func render(with path: String) {
        guard let cookie = self.setCookie(path: path) else { return }
        let configuration = self.setWebConfiguration(with: cookie)
        let webView = WKWebView(frame: self.view.frame, configuration: configuration)
        webView.uiDelegate = self
		webView.navigationDelegate = self
        self.view.addSubview(webView)

        guard let url = URL(string: "\(Self.Constant.domain)\(path)") else { return }
        let URLRequest = URLRequest(url: url)
        webView.load(URLRequest)
    }
}

// MARK: - Private functions

extension MOITWebViewController {
    
    private func setCookie(path: String) -> HTTPCookie? {
        HTTPCookie(properties: [
            .domain: Self.Constant.domain,
            .path: path,
            .name: "accessToken",   // TODO: 합의 후 수정 필요
            .value: "어딘가에서 가지고 온 토큰값"  // TODO: 합의 후 수정 필요
        ])
    }
    
    private func setWebConfiguration(with cookie: HTTPCookie) -> WKWebViewConfiguration {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.isTextInteractionEnabled = false
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

extension MOITWebViewController: WKScriptMessageHandler {
    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        print(#function, message)
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
		switch response.statusCode {
		case (200...299):
			// TODO: token key 뽑는 로직 interactor로 이동시키기
			let authorizationToken = response.allHeaderFields["authroziation"] as? String ?? ""
			listener?.registeredMemberDidSignIn(with: authorizationToken)
			return .cancel
		case 401:
			let headerFields = response.allHeaderFields
			listener?.notRegisteredMemeberDidSignIn(with: headerFields)
			return .cancel
		default:
			return .allow
		}
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
