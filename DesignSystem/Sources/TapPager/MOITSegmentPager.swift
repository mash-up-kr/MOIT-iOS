//
//  MOITSegmentPager.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/07.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import ResourceKit

import RxSwift
import RxGesture

public final class MOITSegmentPager: UIView {

    // MARK: - UI
    private let flexRootView = UIView()
    fileprivate lazy var pages: [UILabel] = []

    private let selectedCircle: UIView = {
        let view = UIView()
        view.backgroundColor = ResourceKitAsset.Color.white.color
        return view
    }()
    
    // MARK: - Properties
    let pagerType: PagerType = .segment

    private let disposebag = DisposeBag()

    // MARK: - Initializers
    public init(
        pages: [String]
    ) {
        super.init(frame: .zero)

        configurePages(pages: pages)
        configureLayout()
        congifureSelectedCircle()
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
            .height(42)
            .cornerRadius(21)
            .alignItems(.center)
            .justifyContent(.spaceAround)
            .direction(.row)
            .backgroundColor(ResourceKitAsset.Color.gray100.color)
            .define { flex in
                flex.addItem(self.selectedCircle)
                    .position(.absolute)
                    .alignSelf(.center)

                flex.addItem()
                    .direction(.row)
                    .marginHorizontal(4)
                    .define { flex in
                        self.pages.forEach { flex.addItem($0).grow(1) }
                    }
                    .grow(1)
            }
    }
    
    private func configurePages(pages: [String]) {
        self.pages = pages.map { self.configureLabel(text: $0) }
    }

    private func configureLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.font = pagerType.font
        label.text = text
        label.textAlignment = .center
        label.textColor = pagerType.disableColor
        return label
    }
    
    private func congifureSelectedCircle() {
        
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
        
        let xPosition = selectedLabel.frame.origin.x + 4
        let width = selectedLabel.frame.width
        let height = 34.0
        
        self.moveCircle(xPosition: xPosition, width: width, height: height)
        UIView.animate(withDuration: 0.25) {
            self.flexRootView.flex.layout()
        }
    }
    
    private func moveCircle(xPosition: CGFloat, width: CGFloat, height: CGFloat = 34) {
        self.selectedCircle.flex
            .define { flex in
                flex.marginLeft(xPosition)
                    .width(width)
                    .height(height)
                    .cornerRadius(height/2)
            }
    }
}

// MARK: - Reactive
extension Reactive where Base: MOITSegmentPager {
    
    public var tapIndex: Observable<Int> {
        
        let observables = base.pages.enumerated().map { index, label in
            label.rx.tapGesture()
                .when(.recognized)
                .map { _ in index }
        }

        return Observable.merge(observables)
    }
}
