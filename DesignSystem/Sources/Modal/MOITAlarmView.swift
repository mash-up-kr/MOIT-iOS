//
//  MOITAlarmView.swift
//  DesignSystem
//
//  Created by 송서영 on 2023/06/04.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import RxSwift
import RxCocoa
import PinLayout
import FlexLayout
import RxGesture

public final class MOITAlarmView: UIView {
    
    // MARK: - Properties
    
    private let type: MOITAlarmType
    private let studyName: String
    private let disposeBag = DisposeBag()
    
    // MARK: - UIComponents
    private let flexRootView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let mainLabel = UILabel()
    private let imageView = UIImageView()
    fileprivate lazy var button = MOITButton(
        type: .medium,
        title: self.type.buttonTitle,
        titleColor: .white,
        backgroundColor: ResourceKitAsset.Color.blue800.color
    )

    // MARK: - LifeCycles
    
    public init(
        type: MOITAlarmType,
        studyName: String
    ) {
        self.studyName = studyName
        self.type = type
        super.init(frame: .zero)
        
        self.configreUI()
        self.configureLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("can not init from coder")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout(mode: .fitContainer)
        self.configureGradient()
    }
}

// MARK: - Private functions

extension MOITAlarmView {
    
    private func configureLayouts() {
        self.addSubview(self.flexRootView)
        
        self.flexRootView.flex
            .direction(.column)
            .paddingHorizontal(16)
            .define { flex in
                
                flex.addItem(self.titleLabel)
                    .marginTop(20)
                
                flex.addItem()
                    .direction(.row)
                    .alignItems(.center)
                    .define { flex in
                        flex.addItem()
                            .define { flex in
                                flex.addItem(self.descriptionLabel)
                                flex.addItem(self.mainLabel)
                            }
                            .grow(1)
                        
                        flex.addItem(self.imageView)
                            .alignSelf(.end)
                            .shrink(1)
                            .aspectRatio(200/130)
                    }
                    .height(130)
                
                flex.addItem(self.button)
//                    .marginHorizontal(16)
                    .marginBottom(19)
                    .width(100%)
            }
//            .width(335)
//            .height(260)
    }
    
    private func configureGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            ResourceKitAsset.Color.black.color.cgColor,
            UIColor.init(red: 34/255, green: 37/255, blue: 93/255, alpha: 1.0).cgColor
        ]
        
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = self.flexRootView.bounds
        self.flexRootView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func generateTimerString(
        remainSeconds: Int,
        second: Int
    ) -> String? {
        let remainSecond = remainSeconds - second
        let minute = remainSecond / 60
        let second = remainSecond % 60
        
        if second < 10 { return "\(minute):0\(second)" }
        else { return "\(minute):\(second)" }
    }
    
    private func subscribeRemainTimer() {
        Observable<Int>.interval(
            .seconds(1),
            scheduler: ConcurrentDispatchQueueScheduler.init(qos: .background)
        )
        .map { $0 + 1 }  // 0초부터 카운팅 방지
        .take(while: { [weak self] second in
            guard let self = self else { return true }
            switch self.type {
            case .attendanceCheck(let remainSeconds): return (remainSeconds + 1) != second
            default: return true
            }
        })
        .filter { [weak self] second in
            guard let self = self else { return false }
            switch self.type {
            case .attendanceCheck(let remainSeconds): return remainSeconds >= second
            default: return false
            }
        }
        .compactMap { [weak self] second -> String? in
            guard let self = self else { return nil }
            switch self.type {
            case .attendanceCheck(let remainSeconds): return self.generateTimerString(remainSeconds: remainSeconds, second: second)
            default: return nil
            }
        }
        .observe(on: MainScheduler.instance)
        .bind(onNext: { [weak self] remainTime in
            self?.mainLabel.text = remainTime
            self?.mainLabel.flex.markDirty()
            self?.setNeedsLayout()
        })
        .disposed(by: self.disposeBag)
    }
    
    private func configreUI() {
        self.configureFlexRootView()
        self.configureTitleLabel()
        self.configureDescriptionLabel()
        self.configureMainLabel()
        self.configureImageView()
    }
    
    private func configureFlexRootView() {
        self.flexRootView.layer.cornerRadius = 20
        self.flexRootView.clipsToBounds = true
    }
    
    private func configureImageView() {
        // TODO: 서버에서 이미지도 내려주는지 확인 필요
        self.imageView.image = ResourceKitAsset.Icon.ch01.image
    }
    
    private func configureTitleLabel() {
        // TODO: 서버에서 문구 자체를 다 내려주는지 확인 필요
        self.titleLabel.text = self.type.alarmTitle(with: self.studyName)
        self.titleLabel.font = ResourceKitFontFamily.h5
        self.titleLabel.textColor = .white
        self.titleLabel.numberOfLines = 2
    }
    
    private func configureDescriptionLabel() {
        self.descriptionLabel.text = self.type.descriptionTitle
        self.descriptionLabel.font = ResourceKitFontFamily.p2
        self.descriptionLabel.textColor = ResourceKitAsset.Color.gray500.color
    }
    
    private func configureMainLabel() {
        switch self.type {
        case .attendanceCheck(let remainSeconds):
            self.subscribeRemainTimer()
            self.mainLabel.text = self.generateTimerString(remainSeconds: remainSeconds, second: 0)
        case .penalty(let amount):
            self.mainLabel.text = amount
        case .attendanceRating:
            self.mainLabel.text = ""
        }
    
        self.mainLabel.font = ResourceKitFontFamily.h2
        self.mainLabel.textColor = ResourceKitAsset.Color.blue200.color
    }
}

// MARK: - Reactive
extension Reactive where Base: MOITAlarmView {
    public var didTapButton: Observable<Void> {
        self.base.button.rx.tap
    }
}
