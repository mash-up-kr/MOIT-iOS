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
import Utils

import FlexLayout
import PinLayout
import RIBs
import RxSwift

protocol MOITAlarmPresentableListener: AnyObject {
    func didSwipeBack()
	func viewDidLoad()
    func didTapBack()
    func didTapItem(at index: Int)
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
	private let emptyLabel: UILabel = {
		let label = UILabel()
		label.setTextWithParagraphStyle(
			text: "아직 받은 알림이 없어요!",
			alignment: .center,
			font: ResourceKitFontFamily.p3,
			textColor: ResourceKitAsset.Color.gray600.color
		)
		return label
	}()
	private let disposeBag = DisposeBag()
    
    private var items: [MOITAlarmCollectionViewCellItem] = [
    ]
    weak var listener: MOITAlarmPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		listener?.viewDidLoad()
		
        view.backgroundColor = .white
        flexRootView.backgroundColor = .white
        collectionView.backgroundColor = .white
        configureCollectionView()
        define()
        collectionView.reloadData()
		bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flexRootView.pin.top(view.pin.safeArea).bottom().horizontally()
        flexRootView.flex.layout()
		emptyLabel.pin.hCenter().vCenter()
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
			flex.addItem(emptyLabel).position(.absolute)
        }
    }
	
	private func bind() {
		self.navigationView.leftItems?[0].rx.tap.subscribe(onNext: { [weak self] in
			self?.listener?.didTapBack()
		}).disposed(by: self.disposeBag)
	}
}

// MARK: - MOITAlarmPresentable
extension MOITAlarmViewController {
	func configure(_ collectionViewCellItems: [MOITAlarmCollectionViewCellItem]) {
		
		if collectionViewCellItems.isEmpty {
			emptyLabel.flex.display(.flex)
			collectionView.flex.display(.none)
            emptyLabel.isHidden = false
		} else {
			items = collectionViewCellItems
			collectionView.reloadData()
            emptyLabel.isHidden = true
            
			emptyLabel.flex.display(.none)
			collectionView.flex.display(.flex)
		}
		
		emptyLabel.flex.markDirty()
		collectionView.flex.markDirty()
		self.view.setNeedsLayout()
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

// MARK: - UICollectionViewDelegate

extension MOITAlarmViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        self.listener?.didTapItem(at: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MOITAlarmViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 95)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        .zero
    }
}
