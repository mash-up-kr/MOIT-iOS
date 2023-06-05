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
import RxSwift

final class BottomSheetDemoViewController: UIViewController {

    private let flexRootView = UIView()
    private let button = UIButton()
    private let debugLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.configureLayouts()
        self.button.setTitle("궁금하면 클릭해보시오@!", for: .normal)
        self.button.addTarget(self, action: #selector(self.didTapButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func didTapButton(_ sender: UIButton) {
        let view = MOITShareView(invitationCode: "MZ9750")
        let vc = BottomSheetViewController(contentView: view)
        
        vc.rx.didTapDimmedView
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: self.disposeBag)
        
        view.rx.didTapLinkCopyButton
            .bind(onNext: { [weak self] in
                self?.debugLabel.text = "링크 복사하기 클릭됨 ~"
                self?.debugLabel.flex.markDirty()
                self?.view.setNeedsLayout()
            })
            .disposed(by: self.disposeBag)
        
        view.rx.didTapKakaoTalkShareButton
            .bind(onNext: { [weak self] in
                self?.debugLabel.text = "카카오톡으로 공유하기 클릭됨 ~"
                self?.debugLabel.flex.markDirty()
                self?.view.setNeedsLayout()
            })
            .disposed(by: self.disposeBag)
        
        self.present(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout()
    }
    
    private func configureLayouts() {
        self.view.addSubview(self.flexRootView)
        self.debugLabel.textColor = .white
        self.flexRootView.flex
            .define { flex in
                
                flex.addItem(self.debugLabel)
                    .alignSelf(.center)
                    .height(20)
                
                flex.addItem(MOITShareView(invitationCode: "저ㄴㅈr"))
                    .marginTop(10)
                
                flex.addItem(self.button)
                    .marginTop(40)
            }
    }
}
