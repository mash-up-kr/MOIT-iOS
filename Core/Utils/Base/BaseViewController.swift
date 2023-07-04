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
    
    // MARK: - Properties
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
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
    /// function to set the value
    open func configureAttributes() {
        hideKeyboardWhenTapped()
    }
    /// Function to bind.
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
        self.flexRootView.flex.layout()
        self.flexRootView.flex.markDirty()
    }
}
