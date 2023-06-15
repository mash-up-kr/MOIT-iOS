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
    fileprivate let flexRootView = TouchThroughView()
    
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
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(ResourceKitAsset.Icon.trash.image.withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private var disposebag = DisposeBag()
    
    fileprivate let deleteConfirmSubject = PublishSubject<Void>()
    fileprivate let didTapSubject = PublishSubject<Void>()
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
    }
    
    public init(
        remainingDate: Int,
        profileURLString: String,
        studyName: String,
        studyProgressDescription: String?
    ) {
        super.init(frame: .zero)
        configure(
            remainingDate: remainingDate,
            profileURL: profileURLString,
            studyName: studyName,
            studyProgressDescription: studyProgressDescription
        )
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("required init called")
    }
    
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    public func configure(
        remainingDate: Int,
        profileURL: String,
        studyName: String,
        studyProgressDescription: String?
    ) {
        
        configureAttributes(
            remainingDate: remainingDate,
            profileURLString: profileURL,
            studyName: studyName,
            studyProgressDescription: studyProgressDescription
        )
        configureLayout()
        setupGesture()
    }

    private func setupGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tapGestureRecognizer.delegate = self
        panGestureRecognizer.delegate = self
        flexRootView.addGestureRecognizer(panGestureRecognizer)
        flexRootView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(flexRootView)
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
        self.clipsToBounds = true
    }
    
    private func configureLayout() {
        
        self.flexRootView.flex
            .direction(.row)
            .define { flex in
                flex.addItem() // 보이는 뷰
                    .paddingLeft(16)
                    .marginRight(10)
                    .width(100%)
                    .height(100)
                    .cornerRadius(30)
                    .backgroundColor(.white)
                    .alignItems(.center)
                    .direction(.row)
                    .define { flex in
                        flex.addItem(profileImageView)
                            .size(60)
                            .marginRight(10)
                        
                        flex.addItem()
                            .direction(.column)
                            .height(66)
                            .alignItems(.start)
                            .justifyContent(.spaceBetween)
                            .define { flex in
                                flex.addOptionalItem(remainingDateLabel)
                                flex.addItem()
                                    .define { flex in
                                        flex.addItem(studyNameLabel)
                                        flex.addItem(studyDescriptionLabel)
                                    }
                            }
                    }
                
                flex.addItem(deleteButton) // 옆에 버튼
                    .backgroundColor(ResourceKitAsset.Color.orange100.color)
                    .aspectRatio(0.77)
                    .cornerRadius(20)
            }
    }
    
    private func configureAttributes(
        remainingDate: Int,
        profileURLString: String,
        studyName: String,
        studyProgressDescription: String?
    ) {
        deleteButton.setImage(ResourceKitAsset.Icon.trash.image.withTintColor(.white), for: .normal)
        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        flexRootView.button = deleteButton
        
        remainingDateLabel = MOITChip(type: .dueDate(date: remainingDate))
        
        if let url = URL(string: profileURLString) {
            profileImageView.kf.setImage(
                with: url,
                options: [.processor(RoundCornerImageProcessor(cornerRadius: 20))]
            )
        }
        
        studyNameLabel.text = studyName
        
        studyDescriptionLabel.text = studyProgressDescription
        self.flexRootView.flex.markDirty()
    }
    
    @objc private func onPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        var originalTransform: CGAffineTransform?
        
        let translation = gestureRecognizer.translation(in: flexRootView)
        let velocity = gestureRecognizer.velocity(in: flexRootView)
        
        switch gestureRecognizer.state {
        case .began:
            originalTransform = flexRootView.transform
        case .changed:
            if let originalTransform = originalTransform {
                let totalTranslationX = originalTransform.tx + translation.x
                if totalTranslationX < 0 && totalTranslationX > -(self.deleteButton.frame.width + 10) {
                    flexRootView.transform = CGAffineTransform(translationX: totalTranslationX, y: 0)
                }
            }
        case .ended:
            if velocity.x < 0 {
                UIView.animate(withDuration: 0.2) {
                    self.flexRootView.transform = CGAffineTransform(
                        translationX: -(self.deleteButton.frame.width + 10),
                        y: 0
                    )
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.flexRootView.transform = CGAffineTransform.identity
                }
            }
            originalTransform = nil
        default:
            break
        }
    }
    
    @objc private func didTap(_ gestureRecognizer: UITapGestureRecognizer) {
        self.didTapSubject.onNext(())
    }
    
    @objc private func didTapDelete() {
        let alert = UIAlertController(
            title: "\(self.studyNameLabel.text ?? "") 스터디를 삭제할까요?",
            message: "스터디를 삭제하면 해당 데이터도 모두 삭제됩니다.",
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.deleteConfirmSubject.onNext(())
        }
        let cancelAction = UIAlertAction(title: "취소", style: .destructive)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        self.window?.rootViewController?.present(alert, animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MOITStudyPreview: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer {
            return otherGestureRecognizer is UITapGestureRecognizer
        }
        return false
    }
}

// MARK: - Reactive
public extension Reactive where Base: MOITStudyPreview {
    
    var didConfirmDelete: Observable<Void> {
        return base.deleteConfirmSubject.asObservable()
    }
    
    var didTap: Observable<Void> {
        return base.didTapSubject.asObservable()
    }
}
