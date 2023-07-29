//
//  ThumbnailCollectionViewCell.swift
//  MOITListUserInterface
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem
import Utils

import PinLayout
import FlexLayout

final class ThumbnailCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: UI
    
    private var alarmView: MOITAlarmView!
    
    // MARK: Properties
    
    // MARK: Initializers
    init(viewType: MOITAlarmType, studyName: String) {
        super.init(frame: .zero)
        configure(viewType: viewType, studyName: studyName)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    // MARK: Methods
    
    override func configureConstraints() {
        super.configureConstraints()
    }
    
    public func configure(viewType: MOITAlarmType, studyName: String) {
        let alarmView = MOITAlarmView(type: viewType, studyName: studyName)
        self.alarmView = alarmView
        
        flexRootView.flex.define { flex in
            flex.addItem(self.alarmView)
                .width(100%)
                .height(100%)
                .alignSelf(.center)
                .grow(1)
                .layout(mode: .fitContainer)
        }
        
        self.alarmView.flex.layout(mode: .fitContainer)
        flexRootView.flex.layout(mode: .fitContainer)
    }
}
