//
//  BottomSheetViewController.swift
//  DesignSystem
//
//  Created by 송서영 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit

import ResourceKit

import FlexLayout
import PinLayout
import RxSwift
import RxCocoa
import RxGesture

public final class BottomSheetViewController: UIViewController {
    
    private let flexRootView = UIView()
    private let contentRootView = UIView()
    private let contentView: UIView
    fileprivate let dimmedView = UIView()
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.addSubview(self.flexRootView)
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
        self.contentView.pin.top(20)
            .left()
            .right()
            .bottom()
    }
    
    public init(contentView: UIView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayouts()
        self.contentRootView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.contentRootView.layer.cornerRadius = 40
        self.contentRootView.clipsToBounds = true
        self.contentRootView.backgroundColor = .white
    }
    
    private func configureLayouts() {
        self.view.addSubview(self.flexRootView)
        self.dimmedView.backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 24/255, alpha: 0.5)
        
        self.flexRootView.backgroundColor = .clear
        self.flexRootView.flex
            .define { flex in
                flex.addItem(self.dimmedView)
                    .define { flex in
                        flex.addItem()
                            .grow(1)
                        
                        flex.addItem(self.contentRootView)
                            .define { flex in
                                flex.addItem(self.contentView)
                                    .position(.absolute)
                            }
                            .grow(1)
                            .marginBottom(0)
                    }
                    .grow(1)
            }
    }
}

extension Reactive where Base: BottomSheetViewController {
    public var didTapDimmedView: Observable<Void> {
        self.base.dimmedView.rx.tapGesture()
            .when(.recognized)
            .throttle(.milliseconds(400), latest: false, scheduler: MainScheduler.instance)
            .map { _ in return }
    }
}

public final class MOITShareView: UIView {
    private let flexRootView = UIView()
    
    private let titleLabel = UILabel()
    
    private let descriptionLabel = UILabel()
    private let invitationCodeBackgroundView = UIView()
    private let invitationCodeTitleLabel = UILabel()
    private let invitationCodeLabel = UILabel()
    fileprivate let kakaoTalkShareButton = MOITButton(
        type: .large,
        image: ResourceKitAsset.Icon.kakaotalk.image,
        title: "카카오톡으로 공유하기",
        titleColor: .black,
        backgroundColor: ResourceKitAsset.Color.kakao.color
    )
    fileprivate let linkCopyButton = MOITButton(
        type: .large,
        image: ResourceKitAsset.Icon.link.image,
        title: "링크 복사하기",
        titleColor: .black,
        backgroundColor: ResourceKitAsset.Color.gray200.color
    )
    
    private let invitationCode: String
    
    public init(invitationCode: String) {
        self.invitationCode = invitationCode
        super.init(frame: .zero)
        
        self.titleLabel.text = "초대링크 공유하기"
        self.titleLabel.font = ResourceKitFontFamily.h5
        self.titleLabel.textColor = ResourceKitAsset.Color.gray900.color
        
        self.descriptionLabel.text = "초대코드를 공유해 친구를 스터디에 초대하세요\n코드는 절대 외부에 공개하지 말기!"
        self.descriptionLabel.font = ResourceKitFontFamily.p3
        self.descriptionLabel.textColor = ResourceKitAsset.Color.gray900.color
        self.descriptionLabel.numberOfLines = 0
        
        self.invitationCodeBackgroundView.backgroundColor = ResourceKitAsset.Color.gray100.color
        self.invitationCodeBackgroundView.layer.cornerRadius = 6
        self.invitationCodeBackgroundView.clipsToBounds = true
        self.invitationCodeBackgroundView.layer.borderColor = ResourceKitAsset.Color.gray200.color.cgColor
        self.invitationCodeBackgroundView.layer.borderWidth = 1
        
        self.invitationCodeTitleLabel.text = "스터디 초대 코드"
        self.invitationCodeTitleLabel.font = ResourceKitFontFamily.p3
        
        self.invitationCodeLabel.text = self.invitationCode
        self.invitationCodeLabel.font = ResourceKitFontFamily.h2
        self.flexRootView.backgroundColor = .white
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("can not init from coder")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout(mode: .adjustHeight)
    }
    
    private func configureLayouts() {
        self.addSubview(self.flexRootView)
        
        self.flexRootView.flex
            .alignItems(.start)
            .define { flex in
                flex.addItem()
                    .justifyContent(.center)
                    .define { flex in
                        flex.addItem(self.titleLabel)
                            .marginHorizontal(20)
                    }
                    .height(56)
                
                flex.addItem(self.descriptionLabel)
                    .marginTop(20)
                    .marginHorizontal(20)
                
                flex.addItem(self.invitationCodeBackgroundView)
                    .alignSelf(.center)
                    .define { flex in
                        flex.addItem(self.invitationCodeTitleLabel)
                            .alignSelf(.center)
                            .marginTop(12)
                            .height(22)
                        
                        flex.addItem(self.invitationCodeLabel)
                            .alignSelf(.center)
                            .marginTop(10)
                            .marginBottom(12)
                            .height(48)
                    }
                    .marginTop(20)
                    .width(224)
                
                flex.addItem()
                    .alignSelf(.center)
                    .marginHorizontal(16)
                    .define { flex in
                        flex.addItem(self.kakaoTalkShareButton)
                            .marginTop(20)
                        flex.addItem(self.linkCopyButton)
                            .marginTop(10)
                            .marginBottom(36)
                    }
                    
            }
    }
}

extension Reactive where Base: MOITShareView {
    public var didTapKakaoTalkShareButton: Observable<Void> {
        self.base.kakaoTalkShareButton.rx.tap
    }
    public var didTapLinkCopyButton: Observable<Void> {
        self.base.linkCopyButton.rx.tap
    }
}
