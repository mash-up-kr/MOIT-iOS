//
//  MOITDetailViewController.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import ResourceKit
import DesignSystem
import FlexLayout
import PinLayout

protocol MOITDetailPresentableListener: AnyObject {
}

final class MOITDetailViewController: UIViewController,
                                      MOITDetailPresentable,
                                      MOITDetailViewControllable {
    
    // MARK: - UIComponents
    
    private let flexRootView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let moitImageView = UIImageView()
    private let navigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(ResourceKitAsset.Icon.arrowLeft.image.withTintColor(.white), for: .normal)
        return button
    }()
    private let moitNameLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.h6
        label.textColor = .white
        label.numberOfLines = 1
        label.text = "전자군단 스터디"
        return label
    }()
    private let participantsButton: UIButton = {
        let button = UIButton()
        button.setImage(ResourceKitAsset.Icon.user.image.withTintColor(.white), for: .normal)
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(ResourceKitAsset.Icon.share.image.withTintColor(.white), for: .normal)
        return button
    }()
    
    private let sheetScrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    private let sheetContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    // MARK: - Properties
    
    weak var listener: MOITDetailPresentableListener?
    
    override func loadView() {
        super.loadView()
        self.view = self.flexRootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        self.configureLayouts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
        self.navigationBar.pin.top(self.view.pin.safeArea)
            .left()
            .right()
        self.navigationBar.flex.layout()
        
        self.moitNameLabel.pin.center(to: self.navigationBar.anchor.center)
    }
    
    private func configureLayouts() {
        
        self.navigationBar.flex
            .direction(.row)
            .alignItems(.center)
            .justifyContent(.spaceEvenly)
            .define { flex in
                flex.addItem(self.backButton)
                    .size(24)
                    .marginLeft(16)
                
                flex.addItem(self.moitNameLabel)
                    .position(.absolute)
                    
             
                flex.addItem()
                    .grow(1)
                
                flex.addItem(self.participantsButton)
                    .size(24)
                    .marginRight(20)
                
                flex.addItem(self.shareButton)
                    .size(24)
                    .marginRight(16)
            }
            .height(56)
        
        self.flexRootView.flex
            .define { flex in
                flex.addItem(self.moitImageView)
                    .define { flex in
                        flex.addItem(self.navigationBar)
                            .position(.absolute)
                    }
                    .backgroundColor(.brown)
                    .height(285)
                
                flex.addItem()
                    .grow(1)
        }
    }
}
