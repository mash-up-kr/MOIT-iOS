//
//  BottomSheetViewController.swift
//  DesignSystem
//
//  Created by 송서영 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit

import FlexLayout
import PinLayout

final class BottomSheetViewController: UIViewController {
    
    private let flexRootView = UIView()
    private let contentRootView = UIView()
    private let dimmedView = UIView()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.addSubview(self.flexRootView)
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
