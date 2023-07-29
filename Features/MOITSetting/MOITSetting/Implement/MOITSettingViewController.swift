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
    func didTapBackButton()
    func didSwipeBack()
    func didTap프로필수정()
    func didTap개인정보처리방침()
    func didTap서비스이용약관()
    func didTap피드백()
    func didTap계정삭제()
    func didTap로그아웃()
    // alert에서 누른 액션
    func didTap삭제Action()
    func didTap로그아웃Action()
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
    private let dispoesBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        self.flexRootView.backgroundColor = .white
        define()
        configureCollectionView()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flexRootView.pin.top(view.pin.safeArea).bottom().horizontally()
        flexRootView.flex.layout()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            listener?.didSwipeBack()
        }
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
    
    private func bind() {
        navigationBar.leftItems?[0].rx.tap
            .bind(onNext: { [weak self] _ in
                self?.listener?.didTapBackButton()
            })
            .disposed(by: self.dispoesBag)
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
        if let titleItem = item as? MOITSettingTitleItemType {
            switch titleItem {
            case .개인정보처리방침:
                self.listener?.didTap개인정보처리방침()
            case .계정삭제:
                self.listener?.didTap계정삭제()
            case .로그아웃:
                self.listener?.didTap로그아웃()
            case .서비스이용약관:
                self.listener?.didTap서비스이용약관()
            case .프로필수정:
                self.listener?.didTap프로필수정()
            case .피드백:
                self.listener?.didTap피드백()
            }
        }
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

// MARK: - MOITSettingPresentable

extension MOITSettingViewController {
    func showLogoutAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message, preferredStyle: .alert)
        let logOutAction = UIAlertAction(
            title: "로그아웃",
            style: .default,
            handler: { [weak self] _ in
                self?.listener?.didTap로그아웃Action()
            }
        )
        let cancelAction = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func showWithdrawAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let removeAction = UIAlertAction(
            title: "삭제",
            style: .default,
            handler: { [weak self] _ in
                self?.listener?.didTap삭제Action()
            }
        )
        let cancelAction = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}
