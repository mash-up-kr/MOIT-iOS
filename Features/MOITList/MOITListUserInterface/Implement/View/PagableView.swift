//
//  PagableView.swift
//  MOITListUserInterface
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit
import Foundation

import DesignSystem
import ResourceKit
import Utils

import FlexLayout
import PinLayout
import RxCocoa

public final class PagableCollectionView: BaseView {
    
    // MARK: UI

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.isPagingEnabled = true
        view.clipsToBounds = true
        view.alwaysBounceHorizontal = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var thumbnailPageControl: UIPageControl = {
        let control = UIPageControl()
        control.tintColor = ResourceKitAsset.Color.gray600.color
        control.isUserInteractionEnabled = false
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    // MARK: Properties
    var thumbnailDidTap: ControlEvent<IndexPath> {
        return collectionView.rx.itemSelected
    }
    
    private var dataSource: DataSource?
    
    // MARK: Initializers
    public override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    // MARK: Methods
    
    public override func configureConstraints() {
        super.configureConstraints()
        self.backgroundColor = .clear
        flexRootView.flex
            .define { flex in
                flex.addItem(collectionView)
                    .height(272)
                    .width(100%)
                    .marginBottom(20)
                
                flex.addItem(thumbnailPageControl)
            }
    }
    
    public override func configureAttributes() {
        super.configureAttributes()
        
        self.configureCollectionView()
        self.dataSource = generateDataSource()
    }
    
    func configure(alarmViewModels: [AlarmViewModel]) {
        thumbnailPageControl.numberOfPages = alarmViewModels.count
        
        let snaphot = generateSnapshot(alarmViews: alarmViewModels)
        dataSource?.apply(snaphot)
    }
}

extension PagableCollectionView: UICollectionViewDelegateFlowLayout {
    
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, AlarmViewModel>
    
    private func configureCollectionView() {
        self.collectionView.register(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: "ThumbnailCollectionViewCell")
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
    }
    
    private func generateDataSource() -> DataSource {
        return DataSource(collectionView: self.collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ThumbnailCollectionViewCell",
                for: indexPath
            ) as? ThumbnailCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.configure(
                viewType: itemIdentifier.alarmType,
                studyName: itemIdentifier.studyName
            )
            return cell
        }
    }
    
    private func generateSnapshot(alarmViews: [AlarmViewModel]) -> NSDiffableDataSourceSnapshot<Section, AlarmViewModel> {
        var snapShot = NSDiffableDataSourceSnapshot<Section, AlarmViewModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(alarmViews, toSection: .main)
        return snapShot
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = self.frame.width
        return CGSize(width: width, height: 272)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        thumbnailPageControl.currentPage = Int(round(page))
    }
}


