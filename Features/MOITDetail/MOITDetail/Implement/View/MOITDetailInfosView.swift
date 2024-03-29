//
//  MOITDetailInfosView.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import MOITDetail
import DesignSystem
import ResourceKit
import MOITFoundation

import FlexLayout
import PinLayout
import RxSwift
import RxCocoa
import SkeletonView

enum MOITDetailInfoViewButtonType {
    /// 닫힘
    case fold
    /// 펼쳐짐
    case unfold
    /// 수정 (스터디장)
    case canEdit
    
    var buttonImage: UIImage {
        switch self {
        case .fold: return ResourceKitAsset.Icon.chevronDown.image
        case .unfold: return ResourceKitAsset.Icon.chevronUp.image
        case .canEdit: return ResourceKitAsset.Icon.edit.image
        }
    }
}

struct MOITDetailInfosViewModel {
    let buttonType: MOITDetailInfoViewButtonType
    let infos: [MOITDetailInfoViewModel]
}

final class MOITDetailInfosView: UIView {

    private let flexRootView = UIView()
    fileprivate let button = UIButton()
    private var infoViews: [MOITDetailInfoView] = []
    fileprivate var buttonType: MOITDetailInfoViewButtonType?
    
    func configure(viewModel: MOITDetailInfosViewModel) {
        self.buttonType = viewModel.buttonType
        let buttonImage = viewModel.buttonType.buttonImage
            .withTintColor(ResourceKitAsset.Color.gray500.color)
        self.button.setImage(buttonImage, for: .normal)
        self.infoViews = viewModel.infos.map { infoViewModel in
            MOITDetailInfoView(viewModel: infoViewModel)
        }
        if viewModel.buttonType == .fold {
            self.infoViews.last?.isHidden = true
            self.infoViews.last?.flex.display(.none)
        }

        self.configureLayouts()
    }
    
    func update(viewModel: MOITDetailInfosViewModel) {
        
        self.buttonType = viewModel.buttonType
        let buttonImage = viewModel.buttonType.buttonImage
            .withTintColor(ResourceKitAsset.Color.gray500.color)
        self.button.setImage(buttonImage, for: .normal)
        
        if viewModel.buttonType == .unfold {
            self.infoViews.last?.isHidden = false
            self.infoViews.last?.flex.display(.flex)
            self.infoViews.last?.flex.markDirty()
        }
        if viewModel.buttonType == .fold {
            self.infoViews.last?.isHidden = true
            self.infoViews.last?.flex.display(.none)
            self.infoViews.last?.flex.markDirty()
        }
        
        self.infoViews.enumerated().forEach { index, infoView in
            guard let updateModel = viewModel.infos[safe: index] else { return }
            infoView.confifugre(viewModel: updateModel)
        }
        self.setNeedsLayout()
    }
    
    init() {
        super.init(frame: .zero)
        self.isSkeletonable = true
        self.flexRootView.backgroundColor = ResourceKitAsset.Color.gray50.color
        self.flexRootView.layer.cornerRadius = 20
        self.flexRootView.clipsToBounds = true
        self.flexRootView.isSkeletonable = true
        self.skeletonCornerRadius = 20
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
    }
    
    private func configureLayouts() {
        self.addSubview(self.flexRootView)
        self.flexRootView.flex
            .define { flex in
                flex.addItem(self.button)
                    .alignSelf(.end)
                    .marginTop(20)
                    .marginRight(11)
                    .size(24)
                
                flex.addItem()
                    .marginTop(-24)
                    .marginVertical(20)
                    .marginLeft(10)
                    .marginRight(45)
                    .define { flex in
                        self.infoViews.enumerated().forEach { index, infoView in
                            if index != 0 {
                                flex.addItem(infoView)
                                    .marginTop(9)
                            } else {
                                flex.addItem(infoView)
                            }
                        }
                    }
            }
    }
}

extension Reactive where Base: MOITDetailInfosView {
    var didTapButton: Observable<MOITDetailInfoViewButtonType> {
        self.base.button.rx.tap
            .throttle(
                .milliseconds(400),
                latest: false,
                scheduler: MainScheduler.instance
            )
            .compactMap { [weak base] _ -> MOITDetailInfoViewButtonType? in
                guard let base else { return nil }
                return base.buttonType
            }
    }
}
