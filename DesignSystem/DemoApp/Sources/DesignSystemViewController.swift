//
//  DesignSystemViewController.swift
//
//  MOIT
//
//  Created by kimchansoo on .
//

import UIKit

fileprivate enum DesignSystemType: String,
                                   CaseIterable {
    case navigation
    case list
    case controlTab
    case input
    case button
    case card
    case modal
}

final class DesignSystemViewController: UITableViewController {
    
    private var designSystems: [DesignSystemType] = DesignSystemType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeContentTitle = "MOIT design System"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        designSystems.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.designSystems[indexPath.item].rawValue
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 50
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let designSystem = self.designSystems[indexPath.item]
        switch designSystem {
        case .navigation:
            let viewController = MOITNavigationDemoViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case .controlTab:
            let viewController = MOITTapPagerDemoViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case .button:
            self.navigationController?.pushViewController(ButtonDemoViewController(), animated: true)
        default: return
        }
    }
}

