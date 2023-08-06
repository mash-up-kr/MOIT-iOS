//
//  MOITAlarmViewController.swift
//  MOITAlarmImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import DesignSystem
import ResourceKit
import MOITFoundation

import FlexLayout
import PinLayout
import RIBs
import RxSwift

protocol MOITAlarmPresentableListener: AnyObject {
    func didSwipeBack()
}

final class MOITAlarmViewController: UIViewController,
                                        MOITAlarmPresentable,
                                     MOITAlarmViewControllable {

    private let navigationView = MOITNavigationBar(leftItems: [.back], title: "알림", rightItems: [])
    private let flexRootView = UIView()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
	private let disposeBag = DisposeBag()
    
    private var items: [MOITAlarmCollectionViewCellItem] = [
        MOITAlarmCollectionViewCellItem(isRead: true, title: "일번알림", description: "일번알림미이이댜fealfijaelfieajhlfiajflieglaigjaleigaeligalghelighagleiglaihgeilhglei러미랴더ㅣ랴ㅓㅁ랴ㅣㄷㅁ너리먀ㅓ랴ㅣㄷ러미ㅑㄷ러미ㅑ럼디ㅑ럼디이이이이이이이", time: "1시간전"),
        MOITAlarmCollectionViewCellItem(isRead: false, title: "일번알림", description: "일번알림미이이이이이이이이이", time: "1시간전"),
        MOITAlarmCollectionViewCellItem(isRead: true, title: "일번알림", description: "일번알림미이이이이이이이이이", time: "1시간전"),
        MOITAlarmCollectionViewCellItem(isRead: false, title: "일번알림", description: "일번알림미이이이이이이이이이", time: "1시간전"),
        MOITAlarmCollectionViewCellItem(isRead: true, title: "일번알림", description: "일번알림미이이이이이이이이이", time: "1시간전"),
        MOITAlarmCollectionViewCellItem(isRead: false, title: "일번알림", description: "일번알림미이이이이이이이이이", time: "1시간전"),
        MOITAlarmCollectionViewCellItem(isRead: true, title: "일번알림", description: "일번알림미이이이이이이이이이", time: "1시간전"),
        MOITAlarmCollectionViewCellItem(isRead: false, title: "일번알림", description: "일번알림미이이이이이이이이이", time: "1시간전"),
        MOITAlarmCollectionViewCellItem(isRead: true, title: "일번알림", description: "일번알림미이이이이이이이이이", time: "1시간전"),
        MOITAlarmCollectionViewCellItem(isRead: false, title: "일번알림", description: "일번알림미이이이이이이이이이", time: "1시간전"),
        MOITAlarmCollectionViewCellItem(isRead: true, title: "일번알림", description: "일번알림미이이이이이이이이이", time: "1시간전"),
        MOITAlarmCollectionViewCellItem(isRead: false, title: "일번알림", description: "일번알림미이이이이이이이이이", time: "1시간전")
    ]
    weak var listener: MOITAlarmPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        flexRootView.backgroundColor = .white
        configureCollectionView()
        define()
        collectionView.reloadData()
		bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flexRootView.pin.all(view.safeAreaInsets)
        flexRootView.flex.layout()
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		if self.isMovingFromParent {
			self.listener?.didSwipeBack()
		}
	}
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            MOITAlarmCollectionViewCell.self,
            forCellWithReuseIdentifier: "MOITAlarmCollectionViewCell"
        )
    }
    
    private func define() {
        self.view.addSubview(flexRootView)
        flexRootView.flex.define { flex in
            flex.addItem(navigationView)
            flex.addItem(collectionView)
                .grow(1)
        }
    }
	
	private func bind() {
		self.navigationView.leftItems?[0].rx.tap.subscribe(onNext: { [weak self] in
			self?.listener?.didSwipeBack()
		}).disposed(by: self.disposeBag)
	}
}

extension MOITAlarmViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let item = self.items[safe: indexPath.item] else { return .init() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MOITAlarmCollectionViewCell", for: indexPath) as? MOITAlarmCollectionViewCell else { fatalError() }
        cell.configure(item: item)
        return cell
    }
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        items.count
    }
}
extension MOITAlarmViewController: UICollectionViewDelegate {
 
}

extension MOITAlarmViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 95)
    }
}
