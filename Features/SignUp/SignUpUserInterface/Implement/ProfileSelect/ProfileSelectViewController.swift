//
//  ProfileSelectViewController.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem

import FlexLayout
import PinLayout
import RxSwift
import RIBs

public protocol ProfileSelectPresentableListener: AnyObject {
    
    func didTapSelectButton(with: Int)
    func didTapDimmedView()
}

public final class ProfileSelectViewContoller: BottomSheetViewController,
                                               ProfileSelectPresentable,
                                               ProfileSelectViewControllable {

    // MARK: - UI
    public let profileView = ProfileSelectView()
    
    // MARK: - Properties
    weak var listener: ProfileSelectPresentableListener?
    
    private var disposebag = DisposeBag()
    
    // MARK: - Initializers
    public init() {
        super.init(contentView: profileView)
        bind()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("\(self) deinit")
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Functions
    
    private func bind() {
        profileView.rx.imageTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, idx in
                print("profileTap: \(idx)")
                guard let profileImageType = ProfileImageType(rawValue: idx) else { return }
                owner.profileView.currentProfileImage.configureImage(with: profileImageType)
            })
            .disposed(by: disposebag)
                
        profileView.rx.selectButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                print("selectButton")
                print(owner.profileView.currentProfileImage.profileImageType)
                guard let imageType = owner.profileView.currentProfileImage.profileImageType else { return }
                owner.listener?.didTapSelectButton(with: imageType.rawValue)
            })
            .disposed(by: disposebag)
        
        self.rx.didTapDimmedView
            .subscribe(onNext: { [weak self] _ in

                self?.listener?.didTapDimmedView()
            })
            .disposed(by: disposebag)
    }
    
    func updateProfileIndex(index: Int?) {
        guard let index = index,
              let imageType = ProfileImageType(rawValue: index) else { return }
        profileView.configureProfileImage(with: imageType)
    }
}
