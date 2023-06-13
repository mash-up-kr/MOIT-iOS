//
//  ProfileDemoViewController.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/13.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem

import RxSwift
import RxGesture

final class ProfileDemoViewController: UIViewController {
    
    // MARK: - UI
    private let largeProfileView = MOITProfileView(
        urlString: "https://avatars.githubusercontent.com/u/15011638?s=64&v=4",
        profileType: .large,
        addButton: true
    )
    
    private let mediumProfileView = MOITProfileView(
        urlString: "https://avatars.githubusercontent.com/u/15011638?s=64&v=4",
        profileType: .medium
    )
    
    private let smallProfileView = MOITProfileView(
        urlString: "https://avatars.githubusercontent.com/u/15011638?s=64&v=4",
        profileType: .small
    )
    
    private let flexRootView = UIView()
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.flexRootView)
        configureLayout()
        bind()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout(mode: .fitContainer)
    }

    
    // MARK: - Functions
    
    private func configureLayout() {
        self.flexRootView.backgroundColor = .white
        self.flexRootView.flex
            .direction(.column)
            .padding(20)
            .alignItems(.center)
            .define { flex in
                flex.addItem(largeProfileView)
                flex.addItem(mediumProfileView)
                flex.addItem(smallProfileView)
            }
    }
    
    private func bind() {
        
    }
}
