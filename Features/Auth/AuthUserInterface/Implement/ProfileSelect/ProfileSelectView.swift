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

public final class ProfileSelectView: BaseView {

    // MARK: - UI
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = ResourceKitFontFamily.h5
        label.textColor = ResourceKitAsset.Color.gray900.color
        label.text = "프로필 이미지 선택하기"
        return label
    }()
    
    public let currentProfileImage = MOITProfileView(profileType: .large)
    
    public var profileImageList: [MOITProfileView] = []
    
    public let selectButton = MOITButton(
        type: .large,
        title: "선택하기",
        titleColor: ResourceKitAsset.Color.white.color,
        backgroundColor: ResourceKitAsset.Color.blue800.color
    )
    
    // MARK: - Properties

    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
    }

    deinit {
        debugPrint("\(self) deinit")
    }

    // MARK: - Lifecycle
    
    
    // MARK: - Functions
    public func configureProfileImage(with imageType: ProfileImageType) {
        currentProfileImage.configureImage(with: imageType)
    }
    
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
            .paddingHorizontal(20)
            .define { flex in
                flex.addItem(titleLabel)
                    .alignSelf(.start)
                    .height(56)
                    .marginBottom(20)
                
                flex.addItem(currentProfileImage)
                    .marginBottom(20)
                
                flex.addItem()
                    .alignContent(.spaceAround)
                    .justifyContent(.center)
                    .direction(.row)
                    .wrap(.wrap)
                    .define { flex in
                        self.profileImageList.forEach {
                            flex.addItem($0)
                                .marginHorizontal(5)
                                .marginBottom(10)
                        }
                    }
                    .marginBottom(20)
                
                flex.addItem(selectButton)
                    .marginBottom(26)
                    .width(100%)
            }
    }
}

public extension Reactive where Base: ProfileSelectView {
 
    var imageTapped: Observable<Int> {
        Observable.merge(
            base.profileImageList.enumerated().map { idx, image in
                image.rx.tap.map { idx }
            }
        )
    }
    
    var selectButtonTapped: Observable<Void> {
        return base.selectButton.rx.tap.asObservable()
    }
}
