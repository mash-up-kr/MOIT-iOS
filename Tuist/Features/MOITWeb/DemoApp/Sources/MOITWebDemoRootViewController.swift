//
//  MOITWebDemoRootViewController.swift
//  MOITWebDemoApp
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation
import UIKit
import MOITWeb

final class MOITWebDemoRootViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let items: [MOITWebPath] = [
        .스터디생성1,
        .스터디생성2
    ]
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Private functions
    private func registerCell() {
        self.tableView.register(MOITWebDemoTableViewCell.self, forCellReuseIdentifier: "MOITWebDemoTableViewCell")
    }
}

// MARK: - TableView

extension MOITWebDemoRootViewController {
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        print(items.count)
        return self.items.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MOITWebDemoTableViewCell") as? MOITWebDemoTableViewCell
        else { fatalError("can not dequeue cell") }
        
        print(cell)
        cell.configure(items[indexPath.item].rawValue)
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 50
    }
}
