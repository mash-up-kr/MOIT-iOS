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
    
    var attendanceRating: CGFloat = 0.7 {
        didSet {
            let attributedString = NSMutableAttributedString(string: "출석", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ])
            attributedString.append(NSAttributedString(string: "\n\(Int(attendanceRating*100))", attributes: [
                .font: ResourceKitFontFamily.h5,
                .foregroundColor: UIColor.white.cgColor
            ]))
            attributedString.append(NSAttributedString(string: "%", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ]))
            self.attendanceRatingLabel.attributedText = attributedString
            print("출석 attr", attributedString)
            self.attendanceRatingLabel.flex.markDirty()
            flexRootView.flex.layout()
        }
    }
    
    var lateRating: CGFloat = 0.2 {
        didSet {
            let attributedString = NSMutableAttributedString(string: "지각\n", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ])
            attributedString.append(NSAttributedString(string: "\(Int(lateRating*100))", attributes: [
                .font: ResourceKitFontFamily.h5,
                .foregroundColor: UIColor.white.cgColor
            ]))
            attributedString.append(NSAttributedString(string: "%", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ]))
            self.lateRatingLabel.attributedText = attributedString
            self.lateRatingLabel.flex.markDirty()
            flexRootView.flex.layout()
        }
    }
    
    var absentRating: CGFloat = 0.1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: "결석\n\n", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ])
            attributedString.append(NSAttributedString(string: "\(Int(absentRating*100))", attributes: [
                .font: ResourceKitFontFamily.h5,
                .foregroundColor: UIColor.white.cgColor
            ]))
            attributedString.append(NSAttributedString(string: "%", attributes: [
                .font: ResourceKitFontFamily.caption,
                .foregroundColor: UIColor.white.cgColor
            ]))
            self.absentRatingLabel.attributedText = attributedString
            self.absentRatingLabel.flex.markDirty()
            flexRootView.flex.layout()
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.bind()
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print(#function, #file)
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
    }
    
    private func bind() {
        self.addSubview(self.flexRootView)
        
        self.flexRootView.flex
            .direction(.row)
            .define { flex in
                let width = UIScreen.main.bounds.width - 40
                print("width", width)
                // 출석
                flex.addItem()
                    .backgroundColor(ResourceKitAsset.Color.blue800.color)
                    .define { flex in
                        flex.addItem(self.attendanceRatingLabel)
                            .margin(10)
                    }
                    .width(self.attendanceRating * width)
                
                // 지각
                flex.addItem()
                    .backgroundColor(ResourceKitAsset.Color.orange200.color)
                    .define { flex in
                        flex.addItem(self.lateRatingLabel)
                            .margin(10)
                    }
                    .width(self.lateRating * width)
                
                
                // 결석
                flex.addItem()
                    .backgroundColor(ResourceKitAsset.Color.orange100.color)
                    .define { flex in
                        flex.addItem(self.absentRatingLabel)
                            .margin(10)
                    }
                    .width(self.absentRating * width)
            }
    }
}
