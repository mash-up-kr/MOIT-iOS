//
//  TableViewAdapter.swift
//  DesignSystem
//
//  Created by 김찬수 on 2023/06/08.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import RxSwift

public final class TableViewAdapter<CellType: ConfigurableCell>: NSObject where CellType: UITableViewCell, CellType: ReactiveCompatible {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CellType.DataType>
    typealias DataSource = UITableViewDiffableDataSource<Section, CellType.DataType>
    
    enum Section {
        case main
    }

    var dataSource: DataSource!
    private var cellDeleteSubjects = [PublishSubject<Void>]()

    var deleteEvents: Observable<Int> {
        return Observable.merge(
            cellDeleteSubjects.enumerated().map { index, subject in
                subject.map { _ in index }
            }
        )
    }
    
    public func setupDataSource(for tableView: UITableView) {
        dataSource = DataSource(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellType
            cell.configure(with: item)
//            self.cellDeleteSubjects[indexPath.row] = (cell as! CustomTableViewCell).deleteButtonTapped
            return cell
        }
        
        dataSource.defaultRowAnimation = .automatic
    }
    
    public func applySnapshot(data: [CellType.DataType], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
