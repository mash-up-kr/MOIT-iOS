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
                                   MOITWebViewControllable,
                                   WKUIDelegate,
                                   WKNavigationDelegate {
    
    weak var listener: MOITWebPresentableListener?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.backgroundColor = .blue
        view = webView
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        print(#function)
    }
}
