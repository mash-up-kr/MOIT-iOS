//
//  MOITAttendanceEmptyView.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/07/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import FlexLayout
import PinLayout
import ResourceKit

final class MOITAttendanceEmptyView: UIView {
    private let flexRootView = UIView()
    private let emptyLabel = UILabel()
    
    init() {
        emptyLabel.text = "출석한 사람이 없어요"
        emptyLabel.font = ResourceKitFontFamily.p3
        emptyLabel.textColor = ResourceKitAsset.Color.gray600.color
        super.init(frame: .zero)
        self.define()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
    }
    
    private func define() {
        self.addSubview(flexRootView)
        flexRootView.flex
            .justifyContent(.center)
            .alignItems(.center)
            .define { flex in
                flex.addItem(emptyLabel)
        }
    }
}
