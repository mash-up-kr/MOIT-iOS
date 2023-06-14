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

import RIBs
import RxSwift

protocol SignUpPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func didSwipeBack()
}

public final class SignUpViewController: UIViewController, SignUpPresentable, SignUpViewControllable {
    
    // MARK: - UI
    private let navigationBar: MOITNavigationBar
    
    // MARK: - Properties
    weak var listener: SignUpPresentableListener?
    
    // MARK: - Initializers
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isMovingFromParent {
            self.listener?.didSwipeBack()
        }
    }
    deinit { debugPrint("\(self) deinit") }
    
    // MARK: - Functions
    
}
