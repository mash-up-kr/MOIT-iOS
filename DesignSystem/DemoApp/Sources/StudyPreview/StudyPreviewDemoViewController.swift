//
//  StudyPreviewDemoViewController.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/08.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem

import PinLayout
import FlexLayout
import RxSwift
import RxGesture

final class StudyPreviewDemoViewController: UIViewController {
    
    // MARK: - UI
    private let studyPreview = MOITStudyPreview(
        remainingDate: 19,
        profileURL: URL(string: "https://avatars.githubusercontent.com/u/15011638?s=64&v=4")!,
        studyName: "공부스터디",
        studyProgressDescription: "공부스터디"
    )
    
    private let flexRootView = UIView()

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Initializers

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.flexRootView)
        self.configureLayouts()
//        self.configurePreview()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout(mode: .fitContainer)
    }

    private func configureLayouts() {
        self.flexRootView.backgroundColor = .systemCyan
        self.flexRootView.flex
            .direction(.column)
            .define { flex in
                flex.addItem(self.studyPreview)
                    .width(100%)
                    .height(100)
                    .backgroundColor(.systemPink)
            }
    }

    
    // MARK: - Methods
}
