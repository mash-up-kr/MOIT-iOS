//
//  SignUpViewController.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//
import UIKit

import AuthUserInterface
import DesignSystem
import Utils
import ResourceKit

import RIBs
import RxSwift
import FlexLayout
import PinLayout

protocol SignUpPresentableListener: AnyObject {
    
    func didSwipeBack()
    func didTapNextButton()
    func didTapProfileView()
    func didTypeName(name: String)
    func didTypeInviteCode(inviteCode: String)
}

public final class SignUpViewController: BaseViewController, SignUpViewControllable {
        
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
        // 랜덤으로 띄워주기로 했었나..
        let profileView = MOITProfileView(
            profileImageType: .one,
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isMovingFromParent {
            self.listener?.didSwipeBack()
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureNavigationBar(
            leftItems: [.back],
            title: "",
            rightItems: []
        )
    }
    
    deinit {
        debugPrint("\(self) deinit")
    }
    
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
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.listener?.didTapProfileView()
            })
            .disposed(by: disposebag)
        
        nameTextField.rx.text
            .withUnretained(self)
            .bind(onNext: { owner, name in
                owner.listener?.didTypeName(name: name)
            })
            .disposed(by: disposebag)
        
        inviteCodeTextField.rx.text
            .withUnretained(self)
            .bind(onNext: { owner, inviteCode in
                owner.listener?.didTypeInviteCode(inviteCode: inviteCode)
            })
            .disposed(by: disposebag)
        
        nextButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.listener?.didTapNextButton()
            })
            .disposed(by: disposebag)
    }
}

extension SignUpViewController: SignUpPresentable {
    
    func updateProfileIndex(index: Int) {
        guard let imageType = ProfileImageType(rawValue: index) else { return }
        self.profileView.configureImage(with: imageType)
    }
}

extension SignUpViewController {
    @objc func keyboardWillShow(_ notification:NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            print("keyboardHeight = \(keyboardHeight)")
            UserDefaults.standard.set(keyboardHeight, forKey: "keyboardHeight")
        }
    }
}
