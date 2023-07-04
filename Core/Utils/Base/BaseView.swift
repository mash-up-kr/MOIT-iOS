//
//  BaseView.swift
//  Utils
//
//  Created by 김찬수 on 2023/06/14.
//

import UIKit

import RxSwift
import FlexLayout
import PinLayout

open class BaseView: UIView {
    
    // MARK: - UI
    public let flexRootView = UIView()
    
    // MARK: - Properties
    public var disposebag = DisposeBag()
    
    // MARK: - Methods
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        configureAttributes()
        configureHierarchy()
        configureConstraints()
        bind()
    }
    
    open func configureHierarchy() {
        self.addSubview(flexRootView)
    }
    open func configureConstraints() {}
    open func configureAttributes() {}
    open func bind() {}
    
    open override func layoutSubviews() {
        flexRootView.pin.all()
        flexRootView.flex.layout(mode: .adjustHeight)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is called.")
    }
}
