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
        self.flexRootView.flex.layout(mode: .adjustWidth)
    }
    
    private func configureLayouts() {
        self.flexRootView.flex
            .define { flex in
                flex.addItem(self.miniButton())
                
                flex.addItem(self.smallButton())
                    .marginTop(10)
                
                flex.addItem(self.mediumButton())
                    .marginTop(10)
                
                flex.addItem(self.largeButton())
                    .marginTop(10)
                
                flex.addItem(self.kakaoButton())
                    .marginTop(10)
                
                flex.addItem(self.appleButton())
                    .marginTop(10)
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
    
    private func mediumButton() -> MOITButton {
        MOITButton(type: .medium, title: "버튼", titleColor: .white, backgroundColor: ResourceKitAsset.Color.blue800.color)
    }
    
    private func largeButton() -> MOITButton {
        MOITButton(
            type: .large,
            title: "긴이름의버튼이들어가게되면이렇게됩니다요예시야요",
            titleColor: ResourceKitAsset.Color.gray700.color,
            backgroundColor: ResourceKitAsset.Color.gray200.color
        )
    }
    
    private func kakaoButton() -> MOITButton {
        MOITButton(
            type: .large,
            image: ResourceKitAsset.Icon.kakaotalk.image,
            title: "카카오톡으로 시작하기",
            titleColor: .black,
            backgroundColor: ResourceKitAsset.Color.kakao.color
        )
    }
    
    private func appleButton() -> MOITButton {
        MOITButton(
            type: .large,
            image: ResourceKitAsset.Icon.apple.image,
            title: "Apple로 시작하기",
            titleColor: .white,
            backgroundColor: .black
        )
    }
}
