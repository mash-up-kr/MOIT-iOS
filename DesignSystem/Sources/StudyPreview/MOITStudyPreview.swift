//
//  StudyPreview.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/08.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import FlexLayout
import Kingfisher
import RxSwift
import RxGesture

public final class MOITStudyPreview: UIView {
    
    // MARK: - UI
    private let flexRootView = UIView()
    
    private var remainingDateLabel: MOITChip?
    private let profileImageView = UIImageView()
    private let studyNameLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.h5
        label.textColor = ResourceKitAsset.Color.gray800.color
        return label
    }()
    
    private let studyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = ResourceKitFontFamily.p3
        label.textColor = ResourceKitAsset.Color.gray600.color
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(ResourceKitAsset.Icon.trash.image.withTintColor(.white), for: .normal)
        return button
    }()
   
    // MARK: - Properties
    private var disposebag = DisposeBag()
    
    // MARK: - Initializers
    public init(remainingDate: Int,
                profileURL: URL,
                studyName: String,
                studyProgressDescription: String?
    ){
        super.init(frame: .zero)
        
        configureAttributes(
            remainingDate: remainingDate,
            profileURL: profileURL,
            studyName: studyName,
            studyProgressDescription: studyProgressDescription
        )
        configureLayout()
        setupGesture()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    private func setupGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        flexRootView.addGestureRecognizer(panGestureRecognizer)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(flexRootView)
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout(mode: .fitContainer)
    }
    
    private func configureLayout() {
        
        
        self.flexRootView.flex
            .direction(.row)
            .define { (flex) in
                flex.addItem()
//                    .marginVertical(19.5)
                    .paddingLeft(16)
                    .marginRight(10)
                    .width(100%)
                    .backgroundColor(.green)
//                    .alignItems(.center) // 얘 하면 왜 iamge 사라짐..?
                    .direction(.row)
                    .define { flex in
                        flex.addItem(profileImageView)
//                            .marginLeft(16)
                            .marginVertical(19.5)
                            .aspectRatio(1.0)
                            .marginRight(10)
                        
                        flex.addItem()
                            .direction(.column)
                            .marginVertical(14)
                            .justifyContent(.spaceBetween)
                            .alignItems(.start)
//                            .alignSelf(.start)
                            .define { flex in
                                flex.addItem(remainingDateLabel ?? UILabel())
                                flex.addItem(studyNameLabel)
                                flex.addItem(studyDescriptionLabel)
                            }
                    }
                    
                
                flex.addItem(deleteButton)
                    .backgroundColor(.orange)
                    .aspectRatio(0.77)
                    .cornerRadius(self.deleteButton.bounds.height / 2)
            }
    }
    
    private func configureAttributes(remainingDate: Int, profileURL: URL, studyName: String, studyProgressDescription: String?) {
        remainingDateLabel = MOITChip(type: .dueDate(date: remainingDate))
        profileImageView.kf.setImage(with: profileURL)
        studyNameLabel.text = studyName
        studyDescriptionLabel.text = studyProgressDescription
        self.flexRootView.flex.markDirty()
        self.layoutIfNeeded()
    }
    
    @objc func onPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: flexRootView)
        let velocity = gestureRecognizer.velocity(in: flexRootView)

        switch gestureRecognizer.state {
        case .began, .changed:
            if translation.x < 0 {
                flexRootView.transform = CGAffineTransform(translationX: translation.x, y: 0)
            }
        case .ended:
            if velocity.x < 0 {
                UIView.animate(withDuration: 0.2) {
                    // Fully reveal the backView
                    self.flexRootView.transform = CGAffineTransform(translationX: -(self.deleteButton.frame.width + 10), y: 0)
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    // Hide the backView
                    self.flexRootView.transform = CGAffineTransform.identity
                }
            }
        default:
            break
        }
    }

}