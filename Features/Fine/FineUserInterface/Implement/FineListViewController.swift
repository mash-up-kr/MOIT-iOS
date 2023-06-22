//
//  FineListViewController.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol FineListPresentableListener: AnyObject { }

final class FineListViewController: UIViewController, FineListPresentable, FineListViewControllable {

    weak var listener: FineListPresentableListener?
}
