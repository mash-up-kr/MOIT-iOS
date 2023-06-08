//
//  SwipeTableViewCell.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/08.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import RxSwift
import FlexLayout
import PinLayout

class SwipeTableViewCell: UITableViewCell {
    
    // MARK: - UI
    let swipeActionView = UIView()
    let deleteButton = UIButton()
    
    let remainingDateLabel = UILabel()
    let profileImageView = UIImageView()
    let studyNameLabel = UILabel()
    let studyProgressDescriptionLabel = UILabel()
    
    // MARK: - Properties
    let deleteButtonTapped = PublishSubject<Void>()

    // Setup your cell components and layout
    
    // MARK: - Initializers
    
    // MARK: - Lifecycle
    
    // MARK: - Functions
    func configure(with model: StudyPreviewModel) {
        remainingDateLabel.text = model.remainingDate
//        profileImageView.kf.setImage(with: model.profileURL) // Using Kingfisher library for image loading
        studyNameLabel.text = model.studyName
        studyProgressDescriptionLabel.text = model.studyProgressDescription
    }
    
    // rest of your SwipeTableViewCell code...
}


extension SwipeTableViewCell: ConfigurableCell {
    typealias DataType = StudyPreviewModel
}




public final class CustomTableViewCell: UITableViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let revealView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40
        view.backgroundColor = .gray // Adjust as needed
        return view
    }()
    
    private let disposebag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setupUI()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(revealView)
        contentView.addSubview(containerView)

        contentView.flex.direction(.row).define { (flex) in
            flex.addItem(revealView).width(100%)
            flex.addItem(containerView).width(100%)
        }
    }

    private func setupGesture() {
        let panGesture = containerView.rx.panGesture().when(.changed, .ended)
        panGesture.subscribe(onNext: { [weak self] pan in
            guard let self = self else { return }
            
            let translation = pan.translation(in: self.containerView)
            if pan.state == .changed {
                if translation.x < -20 {
                    self.containerView.pin.right(translation.x).vCenter()
                }
            } else if pan.state == .ended {
                if translation.x < -20 {
                    UIView.animate(withDuration: 0.2) {
                        self.containerView.pin.right(20).vCenter()
                        self.layoutIfNeeded()
                    }
                } else {
                    UIView.animate(withDuration: 0.2) {
                        self.containerView.pin.right().vCenter()
                        self.layoutIfNeeded()
                    }
                }
            }
        }).disposed(by: disposebag)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.pin.all()
        contentView.flex.layout(mode: .adjustHeight)
    }
}

extension CustomTableViewCell: ConfigurableCell {
    public func configure(with data: StudyPreviewModel) {
        
    }
    
    public typealias DataType = StudyPreviewModel
}
