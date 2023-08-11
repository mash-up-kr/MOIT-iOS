//
//  MOITDetailAttendanceRatingView.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/07/11.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit
import ResourceKit
import FlexLayout
import PinLayout

final class MOITDetailAttendanceRatingView: UIView {
    
    private let flexRootView = UIView()
    
    private let attendanceRatingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    private let lateRatingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    private let absentRatingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    private let attendanceView = UIView()
    private let lateView = UIView()
    private let absentView = UIView()
    
    var attendanceRating: CGFloat = .zero {
        didSet {
            let attributedString = NSMutableAttributedString(string: "출석", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ])
            attributedString.append(NSAttributedString(string: "\n\(Int(attendanceRating))", attributes: [
                .font: ResourceKitFontFamily.h5,
                .foregroundColor: UIColor.white.cgColor
            ]))
            attributedString.append(NSAttributedString(string: "%", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ]))
            self.attendanceRatingLabel.attributedText = attributedString
            self.attendanceRatingLabel.flex.markDirty()
            attendanceView.flex.markDirty()
            bind()
        }
    }
    
    var lateRating: CGFloat = .zero {
        didSet {
            let attributedString = NSMutableAttributedString(string: "지각\n", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ])
            attributedString.append(NSAttributedString(string: "\(Int(lateRating))", attributes: [
                .font: ResourceKitFontFamily.h5,
                .foregroundColor: UIColor.white.cgColor
            ]))
            attributedString.append(NSAttributedString(string: "%", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ]))
            self.lateRatingLabel.attributedText = attributedString
            self.lateRatingLabel.flex.markDirty()
            lateView.flex.markDirty()
            bind()
        }
    }
    
    var absentRating: CGFloat = .zero {
        didSet {
            let attributedString = NSMutableAttributedString(string: "결석\n", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ])
            attributedString.append(NSAttributedString(string: "\(Int(absentRating))", attributes: [
                .font: ResourceKitFontFamily.h5,
                .foregroundColor: UIColor.white.cgColor
            ]))
            attributedString.append(NSAttributedString(string: "%", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ]))
            self.absentRatingLabel.attributedText = attributedString
            self.absentRatingLabel.flex.markDirty()
            absentView.flex.markDirty()
            bind()
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.addSubview(self.flexRootView)
        self.bind()
        self.layer.cornerRadius = 6
        self.flexRootView.layer.cornerRadius = 6
        self.flexRootView.clipsToBounds = true
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
    }
    
    private func bind() {
        
        self.flexRootView.flex
            .direction(.row)
            .define { flex in
                let width = UIScreen.main.bounds.width - 40
                
                // 출석
                flex.addItem(attendanceView)
                    .backgroundColor(ResourceKitAsset.Color.blue800.color)
                    .define { flex in
                        flex.addItem(self.attendanceRatingLabel)
                            .margin(10)
                    }
                    .width((self.attendanceRating/100) * width)
                
                // 지각
                flex.addItem(lateView)
                    .backgroundColor(ResourceKitAsset.Color.orange200.color)
                    .define { flex in
                        flex.addItem(self.lateRatingLabel)
                            .margin(10)
                    }
                    .width((self.lateRating/100) * width)
                
                
                // 결석
                flex.addItem(absentView)
                    .backgroundColor(ResourceKitAsset.Color.orange100.color)
                    .define { flex in
                        flex.addItem(self.absentRatingLabel)
                            .margin(10)
                    }
                    .width((self.absentRating/100) * width)
            }
    }
}
