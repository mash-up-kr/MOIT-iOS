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
import DesignSystem

struct MOITAttendanceStudyViewModel {
    
    enum SeminarFold {
        case unfold   /// 닫힘
        case fold    /// 열림
        
        var image: UIImage? {
            var renderedImage: UIImage?
            switch self {
            case .unfold:
                renderedImage = ResourceKitAsset.Icon.chevronUp.image
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
    let attendances: [MOITDetailAttendanceViewModel.AttendanceViewModel]
    
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
        label.font = ResourceKitFontFamily.h6
        return label
    }()
    private let seminarDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = ResourceKitAsset.Color.gray400.color
        label.numberOfLines = 1
        label.font = ResourceKitFontFamily.p2
        return label
    }()
    private let foldButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ResourceKitAsset.Color.gray50.color
        return view
    }()
    
    private var attendanceViews: [MOITList] = []
    private var isFold: MOITAttendanceStudyViewModel.SeminarFold = .fold
    
    init() {
        super.init(frame: .zero)
        self.addSubview(self.flexRootView)
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
        
        self.flexRootView.flex
            .define { flex in
                flex.addItem()
                    .direction(.row)
                    .alignItems(.center)
                    .define { flex in
                        flex.addItem(self.seminarNameLabel)
                            .height(23)
                        
                        flex.addItem()
                            .grow(1)
                        
                        flex.addItem(self.seminarDateLabel)
                            .height(23)
                        
                        flex.addItem(self.foldButton)
                            .marginLeft(22)
                            .size(24)
                    }
                    .height(60)
                
                flex.addItem(underLineView)
                    .height(1)
                    .marginBottom(0)
                
                self.attendanceViews.enumerated().forEach { index, attendanceView in
                    let flex = flex.addItem(attendanceView)
                    if index != 0 {
                        flex.marginTop(20)
                    }
                    if index == attendanceViews.endIndex {
                        flex.marginBottom(20)
                    }
                }
            }
    }
    
    func configure(viewModel: MOITAttendanceStudyViewModel) {
        self.seminarNameLabel.text = viewModel.name
        self.seminarNameLabel.flex.markDirty()
        
        self.seminarDateLabel.text = viewModel.date
        self.seminarDateLabel.flex.markDirty()
        
        self.foldButton.setImage(viewModel.isFold.image, for: .normal)
        self.isFold = viewModel.isFold
        
        switch viewModel.isFold {
        case .fold: self.underLineView.flex.display(.flex)
        case .unfold: self.underLineView.flex.display(.none)
        }
        self.underLineView.flex.markDirty()
        
        self.attendanceViews = viewModel.attendances.map { viewModel in
            let view = MOITList(
                type: .allAttend,
                imageUrlString: viewModel.profileImageURL,
                title: viewModel.tilte,
                detail: viewModel.detail,
                chipType: viewModel.attendance.toChipeType
            )
            view.flex.markDirty()
            view.flex.display(.none)
            view.isHidden = true
            return view
        }
        
        self.configureLayouts()
    }
    
    func updateFold(_ isFold: MOITAttendanceStudyViewModel.SeminarFold) {
        self.foldButton.setImage(isFold.image, for: .normal)
        self.isFold = isFold
        
        switch isFold {
        case .fold:
            self.underLineView.flex.display(.flex)
            self.attendanceViews.forEach {
                $0.flex.display(.none)
                $0.isHidden = true
                $0.flex.markDirty()
            }
        case .unfold:
            self.underLineView.flex.display(.none)
            self.attendanceViews.forEach {
                $0.flex.display(.flex)
                $0.isHidden = false
                $0.flex.markDirty()
            }
        }
        self.underLineView.flex.markDirty()
    }
}
