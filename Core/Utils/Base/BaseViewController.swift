//
//  BaseViewController.swift
//  Utils
//
//  Created by 김찬수 on 2023/06/14.
//

import UIKit

import DesignSystem

import RxSwift

public class BaseViewController: UIViewController {
    // MARK: - UI
    let flexRootView = UIView()
    
    // TODO: - MOITNavigationBar optional로 만들고 configureNavigationBar에서 설정
    private lazy var navigationBar = MOITNavigationBar(
        leftItems: <#T##[NavigationItemType]#>,
        title: <#T##String?#>,
        rightItems: <#T##[NavigationItemType]#>
    )
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    private var indicator: UIActivityIndicatorView?
    
    // MARK: - LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureAttributes()
        configureHierarchy()
        configureConstraints()
        bind()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout()
    }
    
    // MARK: - Methods
    /// addSubView 하는 함수
    func configureHierarchy() {}
    /// layout 잡는 함수
    func configureConstraints() {}
    /// 값 설정하는 함수
    func configureAttributes() {}
    /// bind하는 함수. (ribs라 필요한지 모르겠음)
    func bind() {}
    
    /// navigationBar 사용하면 flexRootView에 추가해주는 함수
    func configureNavigationBar(
        leftItems: [NavigationItemType],
        title: String?,
        rightItems: [NavigationItemType]
    ) {
        flexRootView.flex
            .addItem(self.navigationBar)
        // TODO: - configure함수 만들어주기
        navigationBar.configure(
            leftItems: leftItems,
            title: title,
            rightItems: rightItems
        )
    }
    

    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is called.")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
}
