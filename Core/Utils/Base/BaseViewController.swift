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
    public let flexRootView = UIView()
    
    // TODO: - MOITNavigationBar optional로 만들고 configureNavigationBar에서 설정
    public lazy var navigationBar = MOITNavigationBar(
        leftItems: [.back],
        title: "야야야",
        rightItems: [.alarm, .setting]
    )
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
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
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout()
        self.flexRootView.backgroundColor = .red
    }
    
    // MARK: - Methods
    /// addSubView 하는 함수
    public func configureHierarchy() {
        self.view.addSubview(flexRootView)
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
        
        // TODO: - configure함수 만들어주기
//        navigationBar.configure(
//            leftItems: leftItems,
//            title: title,
//            rightItems: rightItems
//        )
        view.addSubview(navigationBar)
        
        navigationBar.pin.top(self.view.pin.safeArea.top).horizontally()
        configureRootView()
        
        guard let back = navigationBar.leftItems.first(where: { $0.type == .back }) else { return }
        back.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureRootView() {
        self.flexRootView.pin.below(of: navigationBar).marginTop(10).left().right().bottom()
        self.flexRootView.flex.layout()
//        self.flexRootView.flex.markDirty()
    }
}
