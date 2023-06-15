//
//  SignUpViewController.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//
import UIKit

import SignUpUserInterface
import DesignSystem
import Utils
import ResourceKit

import RIBs
import RxSwift
import FlexLayout
import PinLayout

protocol SignUpPresentableListener: AnyObject {
    
    func didSwipeBack()
}

public final class SignUpViewController: BaseViewController, SignUpPresentable, SignUpViewControllable {
    
    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = ResourceKitFontFamily.h4
        label.textColor = ResourceKitAsset.Color.black.color
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.34
        label.attributedText = NSMutableAttributedString(
            string: "모잇에서 사용할\n프로필을 만들어 주세요.",
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        )
        return label
    }()
    
    private let profileView: MOITProfileView = {
        // TODO: - url 아니라 int형으로 이미지 에셋 받으면 설정
        // 랜덤으로 띄워주기로 했었나..
        let profileView = MOITProfileView(
            urlString: "https://avatars.githubusercontent.com/u/37873745?s=96&v=4",
            profileType: .large,
            addButton: true
        )
        return profileView
    }()
    
    private let nameTextField = MOITTextField(
        title: "이름 (필수)",
        placeHolder: "이름을 입력해주세요."
    )
    private let inviteCodeTextField = MOITTextField(
        title: "스터디 초대 코드 (선택)",
        placeHolder: "공유받은 스터디 초대코드를 입력하세요."
    )
    private let nextButton = MOITButton(
        type: .large,
        title: "다음",
        titleColor: ResourceKitAsset.Color.white.color,
        backgroundColor: ResourceKitAsset.Color.blue800.color
    )
    
    // MARK: - Properties
    weak var listener: SignUpPresentableListener?
    
    // MARK: - Initializers
    public override init() {
        super.init()
    }
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isMovingFromParent {
            self.listener?.didSwipeBack()
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // TODO: - 꼭 여기에 들어가야 할까?
        configureNavigationBar(leftItems: [.back], title: "", rightItems: [])
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    // MARK: - Functions
    public override func configureConstraints() {
        flexRootView.flex
            .alignItems(.start)
            .paddingHorizontal(20)
            .define { flex in
                flex.addItem(titleLabel)
                    .marginTop(20)
                flex.addItem(profileView)
                    .marginTop(20)
                    .alignSelf(.center)
                flex.addItem(nameTextField)
                    .marginTop(20)
                    .width(100%)
                flex.addItem(inviteCodeTextField)
                    .marginTop(20)
                    .width(100%)
                flex.addItem()
                    .grow(1)
                flex.addItem(nextButton)
                    .width(100%)
                    .marginBottom(36)
            }
    }
    
    public override func bind() {
        profileView.rx.tap
            .subscribe(onNext: {
                print("profileTapped")
            })
            .disposed(by: disposebag)
        
        nameTextField.rx.text
            .subscribe(onNext: { name in
                print(name)
            })
            .disposed(by: disposebag)
        
        inviteCodeTextField.rx.text
            .subscribe(onNext: { inviteCode in
                print(inviteCode)
            })
            .disposed(by: disposebag)
        
        nextButton.rx.tap
            .subscribe(onNext: {
                print("nextButtonTapped")
            })
            .disposed(by: disposebag)
    }
}
