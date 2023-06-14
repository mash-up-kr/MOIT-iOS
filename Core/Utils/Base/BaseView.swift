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
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    // MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        configureAttributes()
        configureHierarchy()
        configureConstraints()
        bind()
    }
    
    func configureHierarchy() {}
    func configureConstraints() {}
    func configureAttributes() {}
    func bind() {}
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is called.")
    }
}
