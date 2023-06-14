//
//  SignUpViewController.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//
import UIKit

import SignUpUserInterface
import DesignSystem
import Utils

import RIBs
import RxSwift
import FlexLayout
import PinLayout

protocol SignUpPresentableListener: AnyObject {
    
    func didSwipeBack()
}

public final class SignUpViewController: BaseViewController, SignUpPresentable, SignUpViewControllable {
    
    // MARK: - UI
    //    private let navigationBar: MOITNavigationBar
    private let tempView = UIView()
    
    // MARK: - Properties
    weak var listener: SignUpPresentableListener?
    
    // MARK: - Initializers
    public override init() {
        super.init()
        
    }
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isMovingFromParent {
            self.listener?.didSwipeBack()
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // TODO: - 꼭 여기에 들어가야 할까?
        configureNavigationBar(leftItems: [], title: "hi", rightItems: [])
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    // MARK: - Functions
    public override func configureConstraints() {
        flexRootView.flex
            .alignItems(.center)
            .justifyContent(.center)
            .define { flex in
                flex.addItem(tempView)
                    .width(100%)
                    .height(50)
                    .backgroundColor(.orange)
            }
    }
}
