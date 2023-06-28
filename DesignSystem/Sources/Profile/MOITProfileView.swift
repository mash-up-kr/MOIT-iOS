//
//  MOITProfileView.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/13.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import FlexLayout
import PinLayout
import RxSwift
import RxGesture

public final class MOITProfileView: UIView {
    
    // MARK: - UI
    
    private let profileImageView = UIImageView()
    private lazy var addButton: UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(asset: ResourceKitAsset.Icon.plus)
        return imageView
    }()
    
    // MARK: - Properties
    public private(set) var profileImageType: ProfileImageType?
    private let profileType: ProfileType
    fileprivate let containAddButton: Bool
    
    // MARK: - Initializers
    
    public init (
        profileType: ProfileType,
        addButton: Bool = false
    ) {
        self.profileType = profileType
        self.containAddButton = addButton
        
        super.init(frame: .zero)
        
        configureLayout()
    }
    
    public init (
        profileImageType: ProfileImageType,
        profileType: ProfileType,
        addButton: Bool = false
    ) {
        self.profileImageType = profileImageType
        self.profileType = profileType
        self.containAddButton = addButton
        
        super.init(frame: .zero)
        
        configureImage(with: profileImageType)
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    public override func layoutSubviews() {
        super.layoutSubviews()

        self.profileImageView.pin.size(profileType.size).all()
        self.profileImageView.flex.layout()
        if containAddButton {
            self.addSubview(addButton)
            self.addButton.pin.size(24).bottomRight()
        }
    }
    
    // MARK: - Functions
    
    public func configureImage(with profileImageType: ProfileImageType) {
        self.profileImageType = profileImageType
        profileImageView.image = profileImageType.image
    }
    
    private func configureLayout() {
        addSubview(profileImageView)
        profileImageView.layer.cornerRadius = profileType.radius
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = ResourceKitAsset.Color.gray100.color.cgColor
        profileImageView.flex.size(profileType.size)
    }
}

public extension Reactive where Base: MOITProfileView {
    
    var tap: Observable<Void> {
        base.rx.tapGesture().when(.recognized).map { _ in }
    }
}
