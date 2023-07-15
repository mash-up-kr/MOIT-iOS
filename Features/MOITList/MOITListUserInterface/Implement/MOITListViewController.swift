//
//  MOITListViewController.swift
//  MOITListUserInterfaceImpl
//
//  Created by kimchansoo on 2023/06/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITListUserInterface
import Utils

import RIBs
import RxSwift
import UIKit

protocol MOITListPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class MOITListViewController: BaseViewController, MOITListPresentable, MOITListViewControllable {

    // MARK: - UI
    
    // MARK: - Properties
    weak var listener: MOITListPresentableListener?
    
    // MARK: - Initializers
    public init(listener: MOITListPresentableListener? = nil) {
        self.listener = listener
        super.init()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        self.view.backgroundColor = .cyan
        self.flexRootView.backgroundColor = .systemBlue
    }
    
    // MARK: - Methods
}
