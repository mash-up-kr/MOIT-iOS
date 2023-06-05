//
//  BottomSheetDemoViewController.swift
//  DesignSystemDemoApp
//
//  Created by 송서영 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit

import DesignSystem

import FlexLayout
import PinLayout

final class BottomSheetDemoViewController: UIViewController {

    private let flexRootView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.configureLayouts()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout()
    }
    
    private func configureLayouts() {
        self.view.addSubview(self.flexRootView)
        
        self.flexRootView.flex
            .define { flex in
                flex.addItem(MOITShareView(invitationCode: "MZ9750"))
            }
    }
}
