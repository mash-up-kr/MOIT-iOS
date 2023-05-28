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
    
    private let items = [MOITWebPath.스터디생성1, .스터디생성2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(MOITWebDemoTableViewCell.self, forCellReuseIdentifier: "MOITWebDemoTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(items.count)
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MOITWebDemoTableViewCell") as? MOITWebDemoTableViewCell else { fatalError("can not dequeue cell") }
        print(cell)
        cell.configure(items[indexPath.item].rawValue)
        return cell
    }
}

extension MOITWebDemoRootViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
