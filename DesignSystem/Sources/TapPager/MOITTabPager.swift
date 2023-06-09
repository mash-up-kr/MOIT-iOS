//
//  MOITTabPager.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/05.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import RxSwift
import RxGesture


public final class MOITTabPager: UIView {

    // MARK: - UI
    private let flexRootView = UIView()
    fileprivate lazy var pages: [UILabel] = []

    private lazy var underline: UIView = {
        let view = UIView()
        view.backgroundColor = ResourceKitAsset.Color.gray800.color
        return view
    }()


    // MARK: - Properties
    let pagerType: PagerType = .underline

    private let disposebag = DisposeBag()

    // MARK: - Initializers
    public init(
        pages: [String]
    ) {
        super.init(frame: .zero)

        configurePages(pages: pages)
        configureLayout()
        congifureUnderline()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    public override func layoutSubviews() {
        super.layoutSubviews()

        self.flexRootView.pin.all()
        self.flexRootView.flex.layout(mode: .fitContainer)
        updateSelected(with: 0)
    }
    
    // MARK: - Functions
    
    private func configureLayout() {
        self.addSubview(flexRootView)
        
        self.flexRootView.flex
            .height(84)
            .alignItems(.start)
            .justifyContent(.start)
            .direction(.column)
            .padding(20)
            .define { flex in
                flex.addItem()
                    .direction(.row)
                    .define { flex in
                        self.pages.forEach { flex.addItem($0).marginHorizontal(12)}
                    }
                    .marginBottom(5)
                
                flex.addItem(underline)
                    .width(100)
                    .height(2)
            }
    }
    
    private func configurePages(pages: [String]) {
        self.pages = pages.map { self.configureLabel(text: $0) }
    }

    private func configureLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.font = pagerType.font
        label.text = text
        label.textColor = pagerType.disableColor
        return label
    }
    
    private func congifureUnderline() {
        self.rx.tapIndex
            .withUnretained(self)
            .subscribe(onNext: { owner, index in
                owner.updateSelected(with: index)
            })
            .disposed(by: disposebag)
    }
    
    private func updateSelected(with index: Int) {
        let selectedLabel = pages[index]
        selectedLabel.textColor = self.pagerType.enableColor
        pages.filter { $0 != selectedLabel }.forEach { $0.textColor = self.pagerType.disableColor }
        
        let xPosition = selectedLabel.frame.origin.x
        let width = selectedLabel.frame.width
        
        self.moveUnderline(xPosition: xPosition, width: width)
        UIView.animate(withDuration: 0.25) {
            self.flexRootView.flex.layout()
        }
    }
    
    private func moveUnderline(xPosition: CGFloat, width: CGFloat) {
        self.underline.flex
            .define { flex in
                flex.marginLeft(xPosition)
                    .width(width)
                    .height(2)
                    .marginBottom(6)
            }
    }
}

// MARK: - Reactive
extension Reactive where Base: MOITTabPager {
    
    public var tapIndex: Observable<Int> {
        
        let observables = base.pages.enumerated().map { index, label in
            label.rx.tapGesture()
                .when(.recognized)
                .map { _ in index }
        }

        return Observable.merge(observables)
    }
}
