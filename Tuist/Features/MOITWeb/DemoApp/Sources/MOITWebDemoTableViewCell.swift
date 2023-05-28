//
//  MOITWebDemoTableViewCell.swift
//  MOITWebDemoApp
//
//  Created by 송서영 on 2023/05/28.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation
import UIKit

final class MOITWebDemoTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
    }
    
    func configure(_ title: String) {
        self.titleLabel.frame = self.contentView.frame
        self.titleLabel.textColor = .black
        self.titleLabel.text = title
    }
}
