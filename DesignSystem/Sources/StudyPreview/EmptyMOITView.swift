//
//  EmptyMOITView.swift
//  DesignSystem
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import FlexLayout
import Kingfisher
import RxSwift
import RxGesture

public final class EmptyMOITView: UIView {
    
    // MARK: - UI
    private let flexRootView = UIView()
    
    private let noStudyLabel: UILabel = {
       let label = UILabel()
        label.text = "참여한 스터디가 없어요!"
        label.font = ResourceKitFontFamily.p3
        label.textColor = ResourceKitAsset.Color.gray600.color
        return label
    }()
    
    private let studySuggestionLabel: UILabel = {
       let label = UILabel()
        label.text = "스터디를 생성하거나 참여해보세요"
        label.font = ResourceKitFontFamily.p3
        label.textColor = ResourceKitAsset.Color.gray600.color
        return label
    }()
    
    // MARK: - Properties
    private let disposebag = DisposeBag()
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        configure()
    }
    
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("required init called")
    }

    // MARK: - Lifecycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(flexRootView)
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
        self.flexRootView.layer.cornerRadius = 30
        self.flexRootView.clipsToBounds = true
    }
    
    // MARK: - Methods
    private func configure() {
        
        self.flexRootView.flex
            .justifyContent(.center)
            .alignItems(.center)
            .backgroundColor(.white)
            .define { flex in
                flex.addItem(noStudyLabel)
                    .marginBottom(5)
                flex.addItem(studySuggestionLabel)
            }
    
    }
}
