//
//  MOITUsersViewController.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/07/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import FlexLayout
import PinLayout
import RxCocoa
import DesignSystem
import ResourceKit

protocol MOITUsersPresentableListener: AnyObject {
    func viewDidLoad()
    func didTapBackButton()
}

final class MOITUsersViewController: UIViewController,
                                     MOITUsersPresentable,
                                     MOITUsersViewControllable {
    
    weak var listener: MOITUsersPresentableListener?
    
    private let flexRootView = UIView()
    private let navigationBar = MOITNavigationBar(leftItems: [.back], title: "스터디원", rightItems: [])
    private let totalUsersTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "인원 수 "
        label.textColor = ResourceKitAsset.Color.gray800.color
        label.font = ResourceKitFontFamily.h6
        return label
    }()
    private let totalUsersLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = ResourceKitAsset.Color.blue800.color
        label.font = ResourceKitFontFamily.h6
        return label
    }()
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private var users: [(imageURL: String, name: String)] = []
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(flexRootView)
        self.flexRootView.backgroundColor = .white
        define()
        configureCollectionView()
        bind()
        listener?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flexRootView.pin.top(self.view.pin.safeArea).bottom().horizontally()
        flexRootView.flex.layout()
    }
    
    private func define() {
        flexRootView.flex.define { flex in
            flex.addItem(self.navigationBar)
            
            flex.addItem()
                .direction(.row)
                .define { flex in
                    flex.addItem(self.totalUsersTitleLabel)
                    flex.addItem(self.totalUsersLabel)
                        .grow(1)
                }
                .marginTop(20)
                .marginHorizontal(20)
            
            flex.addItem(collectionView)
                .marginTop(20)
                .marginHorizontal(20)
                .grow(1)
                .marginBottom(0)
        }
    }
    
    private func configureCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(
            MOITUserCollectionViewCell.self,
            forCellWithReuseIdentifier: "MOITUserCollectionViewCell"
        )
        self.collectionView.register(
            MOITUserEmptyCollectionViewCell.self,
            forCellWithReuseIdentifier: "MOITUserEmptyCollectionViewCell"
        )
    }
    
    private func bind() {
        self.navigationBar.leftItems?[safe: 0]?.rx.tap
            .bind(onNext: { [weak self] in
                self?.listener?.didTapBackButton()
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - MOITUsersPresentable

extension MOITUsersViewController {
    func configure(users: [(imageURL: String, name: String)]) {
        self.users = users
        self.totalUsersLabel.text = "\(users.count)"
        self.totalUsersLabel.flex.markDirty()
        self.flexRootView.setNeedsLayout()
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension MOITUsersViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if self.users.isEmpty { return 1 }
        else { return self.users.count }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if self.users.isNotEmpty {
            return self.cellForUser(collectionView, at: indexPath)
        } else {
            return self.cellForEmpty(collectionView, at: indexPath)
        }
    }
    
    private func cellForUser(
        _ collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> MOITUserCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MOITUserCollectionViewCell",
            for: indexPath
        ) as? MOITUserCollectionViewCell,
              let user = self.users[safe: indexPath.item] else { fatalError() }
        cell.configureUser(
            profileImage: user.imageURL,
            name: user.name
        )
        
        return cell
    }
    
    private func cellForEmpty(
        _ collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> MOITUserEmptyCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MOITUserEmptyCollectionViewCell",
            for: indexPath
        ) as? MOITUserEmptyCollectionViewCell else { fatalError() }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MOITUsersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if self.users.isEmpty {
            return  CGSize(
                width: collectionView.bounds.width,
                height: 108
            )
        }
        return CGSize(
            width: collectionView.bounds.width,
            height: 40
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        20
    }
}
