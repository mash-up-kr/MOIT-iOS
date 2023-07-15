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
    func didSwipeBack()
}

final class MOITWebViewController: UIViewController,
                                   MOITWebPresentable,
                                   MOITWebViewControllable {
    
    private enum Constant {
        static let messageName = "MOIT"
        
        // TODO: 합의 후 수정 필요
        static let domain = "https://dev-moit-web.vercel.app"
    }
    
    weak var listener: MOITWebPresentableListener?
    private let contentViewcontroller = WKUserContentController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isMovingFromParent {
            self.removeWKScriptMessageHandler(messageName: Self.Constant.messageName)
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
        self.view.addSubview(webView)

        guard let url = URL(string: "\(Self.Constant.domain)\(path)") else { return }
        print(url)
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
            .name: "accessToken",
            .value: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqd3QtdXNlci1kZWZhdWx0IiwiYXVkIjoiYXV0aDB8YWJjQG5hdmVyLmNvbXw3fGRlZmF1bHQiLCJpc3MiOiJodHRwczovL2dpdGh1Yi5jb20vbWFzaC11cC1rci9NT0lULWJhY2tlbmQiLCJpYXQiOjE2ODg4ODkyOTMsImV4cCI6MTY5MTQ4MTI5MywiaW5mbyI6eyJpZCI6NywicHJvdmlkZXJVbmlxdWVLZXkiOiJhdXRoMHxhYmNAbmF2ZXIuY29tIiwibmlja25hbWUiOiJkZWZhdWx0IiwicHJvZmlsZUltYWdlIjowLCJlbWFpbCI6ImFiY0BuYXZlci5jb20iLCJyb2xlcyI6WyJVU0VSIl19fQ.o9WjiGqNOZSkHGDKQ54b50TUEy-oWvPo1-5Egjw1HXc"
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

enum Command: String {
    case toast
    case back
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
        let value = messages["body"]
        let alertController = UIAlertController(
            title: "\(cmd)",
            message: "\(value)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}

// MARK: - WKUIDelegate

extension MOITWebViewController: WKUIDelegate {
}

// MARK: - WKNavigationDelegate

extension MOITWebViewController: WKNavigationDelegate {
}
