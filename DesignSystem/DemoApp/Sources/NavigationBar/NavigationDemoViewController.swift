//
//  MOITNavigationDemoViewController.swift
//  DesignSystemDemoApp
//
//  Created by kimchansoo on 2023/06/04.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem

import PinLayout
import FlexLayout
import RxSwift
import RxGesture

final class MOITNavigationDemoViewController: UIViewController {
    
    // MARK: - UI
    private let moitNavigationBar = MOITNavigationBar(
        leftItems: [
            .back,
        ],
        title: "MOIT NavigationBar",
        rightItems: [
            .share,
            .close,
        ],
        colorType: .reverse
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
        self.navigationController?.navigationItem.title = "MOITNavigationBar"
        
        self.moitNavigationBar.leftItems[0].rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: self.disposeBag)
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
                flex.addItem(self.moitNavigationBar)
                    .width(100%)
            }
    }
    
    // MARK: - Methods
}
