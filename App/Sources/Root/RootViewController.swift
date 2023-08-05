//
//  RootViewController.swift
//  App
//
//  Created by 송서영 on 2023/05/22.
//

import RIBs
import RxSwift
import UIKit
import FlexLayout
import PinLayout
import RxCocoa
import RxGesture
import ResourceKit

protocol RootPresentableListener: AnyObject {
    func viewDidAppear()
}

final class RootViewController: UIViewController,
                                RootViewControllable,
                                RootPresentable {
    
    var listener: RootPresentableListener?
    private var viewdidAppearCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ResourceKitAsset.Color.gray100.color
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewdidAppearCount == 0 {
            self.listener?.viewDidAppear()
        }
        viewdidAppearCount += 1
    }
    
    deinit { debugPrint("\(self) deinit") }
}
