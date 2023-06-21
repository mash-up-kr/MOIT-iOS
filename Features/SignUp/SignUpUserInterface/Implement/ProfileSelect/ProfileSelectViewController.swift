//
//  ProfileSelectViewController.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/21.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import SignUpUserInterface
import Utils
import ResourceKit
import DesignSystem

import RIBs
import RxSwift
import FlexLayout
import PinLayout

public protocol ProfileSelectPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

public final class ProfileSelectViewController: BaseViewController, ProfileSelectPresentable, ProfileSelectViewControllable {

    // MARK: - UI
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = ResourceKitFontFamily.h5
        label.textColor = ResourceKitAsset.Color.gray900.color
        label.text = "프로필 이미지 선택하기"
        return label
    }()
    
    private let currentProfileImage = MOITProfileView(profileType: .large)
    
    private var profileImageList: [MOITProfileView] = []
    
    private let selectButton = MOITButton(
        type: .large,
        title: "선택하기",
        titleColor: ResourceKitAsset.Color.white.color,
        backgroundColor: ResourceKitAsset.Color.blue800.color
    )
    
    // MARK: - Properties
    weak var listener: ProfileSelectPresentableListener?
    
    // MARK: - Initializers
    public override init() {
        super.init()
    }
    // MARK: - Lifecycle
    
    
    // MARK: - Functions
    public override func configureAttributes() {
        let profileRange = 0...10
        self.profileImageList = profileRange
            .compactMap { ProfileImageType(rawValue: $0) }
            .map {
                return MOITProfileView(
                    profileImageType: $0,
                    profileType: .medium
                )
            }
    }
    
    public override func configureConstraints() {
        flexRootView.flex
            .alignItems(.center)
            .define { flex in
                flex.addItem(titleLabel)
                    .alignSelf(.start)
                    .marginBottom(20)
                
                flex.addItem(currentProfileImage)
                    .marginBottom(20)
                
                flex.addItem()
                    .alignContent(.spaceBetween)
                    .direction(.row)
                    .wrap(.wrap)
                    .define({ flex in
                        self.profileImageList.forEach { flex.addItem($0).marginRight(10) }
                    })
                    .marginBottom(20)
                    
                flex.addItem(selectButton)
                    .marginBottom(36)
                
                
            }
    }
}
