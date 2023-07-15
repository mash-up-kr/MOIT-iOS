//
//  MOITListViewController.swift
//  MOITListUserInterfaceImpl
//
//  Created by kimchansoo on 2023/06/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol MOITListPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class MOITListViewController: UIViewController, MOITListPresentable, MOITListViewControllable {

    // MARK: - UI
    
    // MARK: - Properties
    weak var listener: MOITListPresentableListener?
    
    // MARK: - Initializers
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
}
