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
		let path = navigationResponse.response.url?.path() ?? ""
		
		debugPrint("here url is...\(path)")
		
		// success -> header에서 token 뽑아서 저장
		// 401 -> 받은 response 데이터 signUp RIB에 전달
		
		if let response = navigationResponse.response as? HTTPURLResponse {
			print("webview response status code: \(response.statusCode)")
			print("headerFields: \(response.allHeaderFields)")
			
			switch response.statusCode {
			case (200...299):
			// header에 Jwt 토큰 넘어오는 경우 사용할 수 있지않을까...?!
				let authorizationToken = response.allHeaderFields["authroziation"] as? String ?? ""
				listener?.registeredMemberDidSignIn(with: authorizationToken)
				
				print("success")
				decisionHandler(.allow)
			case (400...499):
				print("clientError")
					
				let headerFields = response.allHeaderFields
				listener?.notRegisteredMemeberDidSignIn(with: headerFields)
					
				decisionHandler(.cancel)
			default:
				print("unknown")
				decisionHandler(.cancel)
			}
		}
	}
}
