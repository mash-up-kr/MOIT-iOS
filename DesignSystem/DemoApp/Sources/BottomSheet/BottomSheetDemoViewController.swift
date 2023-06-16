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
import ResourceKit

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

// MARK: 데모앱을 위해 아래 소스코드가 필요합니다 .. (원본 소스는 Share 모듈에 있음!)
fileprivate final class MOITShareView: UIView {
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
    var didTapKakaoTalkShareButton: Observable<Void> {
        self.base.kakaoTalkShareButton.rx.tap
    }
    var didTapLinkCopyButton: Observable<Void> {
        self.base.linkCopyButton.rx.tap
    }
}
