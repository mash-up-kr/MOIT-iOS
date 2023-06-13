//
//  BottomSheetViewController.swift
//  DesignSystem
//
//  Created by 송서영 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit

import ResourceKit

import FlexLayout
import PinLayout
import RxSwift
import RxCocoa
import RxGesture

open class BottomSheetViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private let flexRootView = UIView()
    private let contentRootView = UIView()
    private let contentView: UIView
    fileprivate let dimmedView = UIView()
    
    // MARK: - LifeCycles
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.addSubview(self.flexRootView)
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
        self.contentView.pin.top(20)
            .left()
            .right()
            .bottom()
    }
    
    public init(contentView: UIView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayouts()
        self.contentRootView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.contentRootView.layer.cornerRadius = 40
        self.contentRootView.clipsToBounds = true
        self.contentRootView.backgroundColor = .white
    }
}

// MARK: - Private functions

extension BottomSheetViewController {
    
    private func configureLayouts() {
        self.view.addSubview(self.flexRootView)
        self.dimmedView.backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 24/255, alpha: 0.5)
        
        self.flexRootView.backgroundColor = .clear
        self.flexRootView.flex
            .define { flex in
                flex.addItem(self.dimmedView)
                    .define { flex in
                        flex.addItem()
                            .grow(1)
                        
                        flex.addItem(self.contentRootView)
                            .define { flex in
                                flex.addItem(self.contentView)
                                    .position(.absolute)
                            }
                            .grow(1)
                            .marginBottom(0)
                    }
                    .grow(1)
            }
    }
}

extension Reactive where Base: BottomSheetViewController {
    public var didTapDimmedView: Observable<Void> {
        self.base.dimmedView.rx.tapGesture()
            .when(.recognized)
            .throttle(
                .milliseconds(400),
                latest: false,
                scheduler: MainScheduler.instance
            )
            .map { _ in return }
    }
}

