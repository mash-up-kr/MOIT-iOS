//
//  ButtonDemoViewController.swift
//  DesignSystem
//
//  Created by 송서영 on 2023/06/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout
import DesignSystem
import ResourceKit

final class ButtonDemoViewController: UIViewController {
    private let flexRootView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.flexRootView)
        self.configureLayouts()
        self.view.backgroundColor = .white
        self.navigationController?.navigationItem.title = "MOITButton"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout()
    }
    
    private func configureLayouts() {
        self.flexRootView.flex
            .margin(20)
            .define { flex in
                flex.addItem(self.miniButton())
                flex.addItem()
                    .height(10)
                flex.addItem(self.smallButton())
                    
            }
    }
    
    private func miniButton() -> MOITButton {
        MOITButton(
            type: .mini,
            title: "납부인증하기",
            titleColor: .white,
            backgroundColor: ResourceKitAsset.Color.blue800.color
        )
    }
    
    private func smallButton() -> MOITButton {
        MOITButton(
            type: .small,
            title: "스터디생성",
            titleColor: ResourceKitAsset.Color.gray700.color,
            backgroundColor: ResourceKitAsset.Color.gray200.color
        )
    }
}
