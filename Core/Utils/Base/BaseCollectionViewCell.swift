//
//  BaseCollectionViewCell.swift
//  Utils
//
//  Created by kimchansoo on 2023/07/23.
//

import UIKit

import RxSwift
import RxCocoa

open class BaseCollectionViewCell: UICollectionViewCell {
    
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
//        self.addSubview(flexRootView)
        self.contentView.addSubview(flexRootView)
    }
    open func configureConstraints() {}
    open func configureAttributes() {}
    open func bind() {}
    
    open override func layoutSubviews() {
//        self.contentView.backgroundColor = .green
//        self.backgroundColor = .black
//        flexRootView.backgroundColor = .blue
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        flexRootView.backgroundColor = .clear
        
        flexRootView.frame = contentView.bounds
        flexRootView.pin.all()
        flexRootView.flex.layout(mode: .fitContainer)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is called.")
    }
}

