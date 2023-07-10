//
//  MOITAttendanceStudyView.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa
import ResourceKit

struct MOITAttendanceStudyViewModel {
    
    enum SeminarFold {
        case unfold   /// 닫힘
        case fold    /// 열림
        
        var image: UIImage? {
            var renderedImage: UIImage?
            switch self {
            case .unfold:
                renderedImage =  ResourceKitAsset.Icon.chevronUp.image
            case .fold:
                renderedImage = ResourceKitAsset.Icon.chevronDown.image
            }
            renderedImage = renderedImage?.withTintColor(ResourceKitAsset.Color.gray500.color)
            return renderedImage
        }
    }
    
    let studyID: String
    let name: String
    let date: String
    var isFold: SeminarFold = .fold
    
    mutating func toggleFold() {
        switch self.isFold {
        case .fold: self.isFold = .unfold
        case .unfold: self.isFold = .fold
        }
    }
}

final class MOITAttendanceStudyView: UIView {
    
    private let flexRootView = UIView()
    private let seminarNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ResourceKitAsset.Color.gray900.color
        label.numberOfLines = 1
        return label
    }()
    private let seminarDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = ResourceKitAsset.Color.gray400.color
        label.numberOfLines = 1
        return label
    }()
    private let foldButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        self.configureLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("🙇‍♀️", #function, String(describing: self))
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
    }
    
    private func configureLayouts() {
        self.addSubview(self.flexRootView)
        self.flexRootView.flex
            .direction(.row)
            .justifyContent(.center)
            .define { flex in
                
                flex.addItem(self.seminarNameLabel)
                    .height(23)
                    .marginVertical(20)
                
                flex.addItem()
                    .grow(1)
                
                flex.addItem(self.seminarDateLabel)
                
                flex.addItem(self.foldButton)
                    .marginLeft(22)
                    .size(24)
                    .alignSelf(.center)
            }
    }
    
    func configure(viewModel: MOITAttendanceStudyViewModel) {
        self.seminarNameLabel.text = viewModel.name
        self.seminarNameLabel.flex.markDirty()
        
        self.seminarDateLabel.text = viewModel.date
        self.seminarDateLabel.flex.markDirty()
        
        self.foldButton.setImage(viewModel.isFold.image, for: .normal)
        self.flexRootView.setNeedsLayout()
    }
}
