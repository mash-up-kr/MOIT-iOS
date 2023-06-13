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
        studyProgressDescription: "격주 금요일 17:00 - 20:00"
    )
    
    private let flexRootView = UIView()

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Initializers
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.flexRootView)
        self.configureLayouts()
        bind()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout(mode: .fitContainer)
    }
    
    // MARK: - Methods
    
    private func configureLayouts() {
        self.flexRootView.backgroundColor = .darkGray
        self.flexRootView.flex
            .direction(.column)
            .alignItems(.center)
            .define { flex in
                flex.addItem(self.studyPreview)
                    .marginTop(40)
                    .width(80%)
                    .height(100)
            }
    }

    private func bind() {
        self.studyPreview.rx.didTap
            .subscribe(onNext: {
                self.showAlert(message: "didtap")
            })
            .disposed(by: disposeBag)
        
        self.studyPreview.rx.didConfirmDelete
            .subscribe(onNext: {
                self.showAlert(message: "delete")
            })
            .disposed(by: disposeBag)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: message,
            message: nil,
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }

}
