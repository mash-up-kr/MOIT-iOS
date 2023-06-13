//
//  MOITWebDemoTableViewCell.swift
//  MOITWebDemoApp
//
//  Created by 송서영 on 2023/05/28.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout

final class MOITWebDemoTableViewCell: UITableViewCell {
    
    // MARK: - UIComponents
    
    private let flexRootView = UIView()
    private let titleLabel = UILabel()
    
    // MARK: - LifeCycles
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
    }
    
    // MARK: - Functions
    
    func configure(_ title: String) {
        self.titleLabel.frame = self.contentView.frame
        self.titleLabel.textColor = .black
        self.titleLabel.text = title
    }
}

// MARK: - Private functions

extension MOITWebDemoTableViewCell {
    private func setupLayouts() {
        self.contentView.addSubview(self.flexRootView)
        self.flexRootView.flex
            .addItem(self.titleLabel)
            .marginHorizontal(20)
            .marginVertical(10)
    }
}
