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
    }
    
    public init(contentView: UIView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
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
        self.flexRootView.backgroundColor = UIColor(red: 24/255, green: 24/255, blue: 24/255, alpha: 0.5)
        
        self.flexRootView.flex
//            .backgroundColor(.clear)
            .define { flex in
                flex.addItem()
                    .define { flex in
                        flex.addItem(dimmedView)
                            .grow(1)
                
                        flex.addItem(contentRootView)
                            .paddingVertical(20)
                            .paddingTop(20)
                            .define { flex in
                                flex.addItem(contentView)
                            }
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

