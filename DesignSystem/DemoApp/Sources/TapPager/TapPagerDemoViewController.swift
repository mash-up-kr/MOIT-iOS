//
//  TapPagerDemoViewController.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/07.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem

import PinLayout
import FlexLayout
import RxSwift
import RxGesture

final class MOITTapPagerDemoViewController: UIViewController {
    
    // MARK: - UI
    
    private let moitTapPager = MOITTabPager(
        pages: ["안녕", "나는", "찬수"]
    )
    
    private let tapResultLabel: UILabel = {
        let label = UILabel()
        label.text = "0번째"
        return label
    }()
    
    private let moitSegmentPager = MOITSegmentPager(
        pages: ["안녕", "나는", "찬수"]
    )
    
    private let segmentResultLabel: UILabel = {
        let label = UILabel()
        label.text = "0번째"
        return label
    }()

    private let flexRootView = UIView()
    
    // MARK: - Properties
    private let disposebag = DisposeBag()
    
    // MARK: - Initializers
    init() {super.init(nibName: nil, bundle: nil)}
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.flexRootView)
        self.configureLayouts()
        self.navigationController?.navigationItem.title = "MOIT Tap Pager"
        self.moitTapPager.rx.tapIndex
            .subscribe(onNext: { index in
                self.tapResultLabel.text = "\(index)번쨰"
            })
            .disposed(by: disposebag)
        
        self.moitSegmentPager.rx.tapIndex
            .subscribe(onNext: { index in
                self.segmentResultLabel.text = "\(index)번쨰"
            })
            .disposed(by: disposebag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout()
    }

    private func configureLayouts() {
        self.flexRootView.backgroundColor = .white
        self.flexRootView.flex
            .padding(20)
            .direction(.column)
            .define { flex in

                flex.addItem(self.moitTapPager)
                    .width(100%)
                    .marginBottom(10)
                
                flex.addItem(self.tapResultLabel)
                    .marginBottom(30)
                
                flex.addItem(self.moitSegmentPager)
                    .width(100%)
                    .marginBottom(10)
                
                flex.addItem(self.segmentResultLabel)
            }
    }
    
    // MARK: - Methods
}

