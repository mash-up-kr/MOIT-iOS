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
import Kingfisher

public final class MOITProfileView: UIView {
    
    // MARK: - UI
    
    private let profileImageView = UIImageView()
    private lazy var addButton: UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(asset: ResourceKitAsset.Icon.plus)
        return imageView
    }()
    
    // MARK: - Properties
    private let urlString: String
    private let profileType: ProfileType
    fileprivate let containAddButton: Bool
    
    // MARK: - Initializers
    public init (
        urlString: String,
        profileType: ProfileType,
        addButton: Bool = false
    ) {
        self.urlString = urlString
        self.profileType = profileType
        self.containAddButton = addButton
        
        super.init(frame: .zero)
        
        configureAttributes()
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
    
    private func configureAttributes() {
        profileImageView.kf.setImage(
            with: URL(string: urlString),
            placeholder: nil
        )
    }
    
    private func configureLayout() {
        addSubview(profileImageView)
        profileImageView.layer.cornerRadius = profileType.radius
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = ResourceKitAsset.Color.blue700.color
        
        profileImageView.flex.size(profileType.size)
    }
}

public extension Reactive where Base: MOITProfileView {
    
    var tap: Observable<Void> {
        if base.containAddButton {
            return base.rx.tapGesture().when(.recognized).map { _ in }
        }
        return .empty()
    }
}
