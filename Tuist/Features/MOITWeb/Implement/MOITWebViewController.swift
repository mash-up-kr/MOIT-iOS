//
//  MOITWebViewController.swift
//  MOITWebImpl
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import WebKit

protocol MOITWebPresentableListener: AnyObject {
}

final class MOITWebViewController: UIViewController,
                                   MOITWebPresentable,
                                   MOITWebViewControllable {
    
    private enum Constant {
        static let messageName = "MOIT"
        static let domain = "https://MOIT"
    }
    
    weak var listener: MOITWebPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        print(#function)
    }
}

// MARK: - MOITWebPresentable

extension MOITWebViewController {
    func render(with path: String) {
        guard let cookie = self.setCookie(path: path) else { return }
        let configuration = self.setWebConfiguration(with: cookie)
        let webView = WKWebView(frame: self.view.frame, configuration: configuration)
        webView.uiDelegate = self
        webView.backgroundColor = .blue
    }
}

// MARK: - Private functions

extension MOITWebViewController {
    
    private func setCookie(path: String) -> HTTPCookie? {
        HTTPCookie(properties: [
            .domain: Self.Constant.domain,
            .path: path,
            .name: "accessToken",
            .value: "어딘가에서 가지고 온 토큰값"
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
        let contentViewcontroller = WKUserContentController()
        contentViewcontroller.add(self, name: messageName)
        return contentViewcontroller
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
}
