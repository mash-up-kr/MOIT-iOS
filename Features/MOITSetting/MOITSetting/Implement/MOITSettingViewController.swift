//
//  MOITSettingViewController.swift
//  MOITSettingImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import DesignSystem
import MOITFoundation

protocol MOITSettingPresentableListener: AnyObject {
}

final class MOITSettingViewController: UIViewController,
                                       MOITSettingPresentable,
                                       MOITSettingViewControllable {
    
    weak var listener: MOITSettingPresentableListener?
    private let navigationBar = MOITNavigationBar(
        leftItems: [.back],
        title: "설정",
        rightItems: []
    )
    private let flexRootView = UIView()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private var items: [MOITSettingItemType] = [
        MOITSettingToggleItemType.앱푸시알림설정,
        MOITSettingDividerItemType.divider,
        MOITSettingTitleItemType.프로필수정,
        MOITSettingDividerItemType.divider,
        MOITSettingTitleItemType.개인정보처리방침,
        MOITSettingDividerItemType.divider,
        MOITSettingTitleItemType.서비스이용약관,
        MOITSettingDividerItemType.divider,
        MOITSettingTitleItemType.피드백,
        MOITSettingDividerItemType.divider,
        MOITSettingTitleItemType.계정삭제,
        MOITSettingDividerItemType.divider,
        MOITSettingTitleItemType.로그아웃,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        self.flexRootView.backgroundColor = .white
        define()
        configureCollectionView()
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flexRootView.pin.top(view.pin.safeArea).bottom().horizontally()
        flexRootView.flex.layout()
    }
    
    private func define() {
        view.addSubview(flexRootView)
        flexRootView.flex.define { flex in
            flex.addItem(navigationBar)
            flex.addItem(collectionView)
                .grow(1)
        }
    }
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            MOITSettingTitleCollectionViewCell.self,
            forCellWithReuseIdentifier: "MOITSettingTitleCollectionViewCell"
        )
        collectionView.register(
            MOITSettingDividerCollectionViewCell.self,
            forCellWithReuseIdentifier: "MOITSettingDividerCollectionViewCell"
        )
        collectionView.register(
            MOITSettingToggleCollectionViewCell.self,
            forCellWithReuseIdentifier: "MOITSettingToggleCollectionViewCell"
        )
    }
}

// MARK: - UICollectionViewDataSource

extension MOITSettingViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        self.items.count
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let item = items[safe: indexPath.item]
        
        if let titleItem = item as? MOITSettingTitleItemType {
            return dequeueTitleCollectionViewCell(collectionView, at: indexPath, item: titleItem)
        }
        if let toggleItem = item as? MOITSettingToggleItemType {
            return dequeueToggleCollectionViewCell(collectionView, at: indexPath, item: toggleItem)
        }
        if let _ = item as? MOITSettingDividerItemType {
            return dequeueDividerCollectionViewCell(collectionView, at: indexPath)
        }
        
        return .init()
    }
    
    private func dequeueTitleCollectionViewCell(
        _ collectionView: UICollectionView,
        at indexPath: IndexPath,
        item: MOITSettingTitleItemType
    ) -> MOITSettingTitleCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MOITSettingTitleCollectionViewCell",
            for: indexPath
        ) as? MOITSettingTitleCollectionViewCell else { return .init() }
        
        cell.configure(title: item.title)
        return cell
    }
    
    private func dequeueToggleCollectionViewCell(
        _ collectionView: UICollectionView,
        at indexPath: IndexPath,
        item: MOITSettingToggleItemType
    ) -> MOITSettingToggleCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MOITSettingToggleCollectionViewCell",
            for: indexPath
        ) as? MOITSettingToggleCollectionViewCell else { return .init() }
        cell.configure(.init(title: item.title, description: item.description, isToggled: true))
        return cell
    }
    
    private func dequeueDividerCollectionViewCell(
        _ collectionView: UICollectionView,
        at indexPath: IndexPath
    ) -> MOITSettingDividerCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MOITSettingDividerCollectionViewCell",
            for: indexPath
        ) as? MOITSettingDividerCollectionViewCell else { return .init() }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MOITSettingViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let item = self.items[safe: indexPath.item] else { return }
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MOITSettingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let item = items[safe: indexPath.item] else { return .zero }
        return .init(
            width: collectionView.bounds.width,
            height: item.height
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        .zero
    }
}
