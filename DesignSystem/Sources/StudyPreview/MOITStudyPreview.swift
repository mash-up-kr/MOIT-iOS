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
    
    let flexRootView = UIView()
    
    let remainingDateLabel = UILabel()
    let profileImageView = UIImageView()
    let studyNameLabel = UILabel()
    let studyProgressDescriptionLabel = UILabel()
    let actionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 40
        return button
    }()
    
    private var disposebag = DisposeBag()
    
    
    public init() {
        super.init(frame: .zero)
        

        
        configureLayout()
        setupGesture()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayout()
        setupGesture()
    }
    
    
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
                flex.addItem(profileImageView).size(50).aspectRatio(1.0)
                flex.addItem(remainingDateLabel)
                flex.addItem(studyNameLabel).margin(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
                flex.addItem(studyProgressDescriptionLabel).margin(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
                flex.addItem(actionButton).backgroundColor(.black).size(100).margin(UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
            }
        actionButton.isHidden = true
    }
    
    public func configure(remainingDate: String?, profileURL: URL?, studyName: String?, studyProgressDescription: String?) {
        remainingDateLabel.text = remainingDate
        profileImageView.kf.setImage(with: profileURL)
        studyNameLabel.text = studyName
        studyProgressDescriptionLabel.text = studyProgressDescription
        self.flexRootView.flex.markDirty()
        self.layoutIfNeeded()
        
    }
    
    @objc func onPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: flexRootView)
        let velocity = gestureRecognizer.velocity(in: flexRootView)
        // TODO: 뷰 길게 뽑고 안보이는 오른쪽에 버튼(뷰) 붙이기
        switch gestureRecognizer.state {
        case .began, .changed:
            if translation.x < 0 { // If swiping to the left
                // Move the frontView to reveal the backView
                flexRootView.transform = CGAffineTransform(translationX: translation.x, y: 0)
            }
        case .ended:
            if velocity.x < 0 { // If swipe to the left
                UIView.animate(withDuration: 0.2) {
                    // Fully reveal the backView
                    self.flexRootView.transform = CGAffineTransform(translationX: -self.actionButton.frame.width, y: 0)
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
