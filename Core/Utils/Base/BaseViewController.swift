//
//  BaseViewController.swift
//  Utils
//
//  Created by 김찬수 on 2023/06/14.
//

import UIKit

import DesignSystem

import RxSwift
import PinLayout
import FlexLayout

open class BaseViewController: UIViewController {
    
    // MARK: - UI
    public let scrollView = UIScrollView()
    public let flexRootView = UIView()
    public lazy var navigationBar = MOITNavigationBar()
    
    // MARK: -Properties
    public var disposebag = DisposeBag()
    
    private var indicator: UIActivityIndicatorView?
    
    // MARK: - Initializer
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init(coder: NSCoder) {
        fatalError("init(coder:) is called.")
    }

    // MARK: - LifeCycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureAttributes()
        configureHierarchy()
        configureConstraints()
        bind()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.pin.all(view.pin.safeArea)
        flexRootView.pin.all()
        flexRootView.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = flexRootView.frame.size
    }
    // MARK: - Methods
    /// addSubView 하는 함수
    public func configureHierarchy() {
        self.scrollView.addSubview(flexRootView)
        self.view.addSubview(scrollView)
    }
    /// layout 잡는 함수
    open func configureConstraints() {}
    /// 값 설정하는 함수
    open func configureAttributes() {}
    /// bind하는 함수. (ribs라 필요한지 모르겠음)
    open func bind() {}
    
    /// navigationBar 사용하면 flexRootView에 추가해주는 함수
    /// `viewDidLayoutSubviews`에 추가해야함
    public func configureNavigationBar(
        leftItems: [NavigationItemType],
        title: String?,
        rightItems: [NavigationItemType]
    ) {
        navigationBar.configure(
            leftItems: leftItems,
            title: title,
            rightItems: rightItems
        )
        
        view.addSubview(navigationBar)
        
        navigationBar.pin.top(self.view.pin.safeArea.top).horizontally()
        configureRootView()
        
        guard let back = navigationBar.leftItems?.first(where: { $0.type == .back }) else { return }
        back.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposebag)
    }
    
    private func configureRootView() {
        self.scrollView.pin.top(self.view.pin.safeArea.top + 56).left().right().bottom() // How to solve it other than absolute value..?
        // scrollview에 딱 맞게 flexRootView를 pinlayout으로 설정
        self.flexRootView.pin.all()
//        flexRootView.backgroundColor = .red
        self.flexRootView.flex.layout()
        self.flexRootView.flex.markDirty()
    }
}
