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
import MOITWebImpl
import SignInDomain

import RIBs

final class MOITWebDemoRootViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let items: [MOITWebPath] = [
        .tv,
        .movie,
    ]
    
    private var webRouter: ViewableRouting?
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Private functions
    
    private func registerCell() {
        self.tableView.register(
            MOITWebDemoTableViewCell.self,
            forCellReuseIdentifier: "MOITWebDemoTableViewCell"
        )
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
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard self.webRouter == nil else { return }
        
        let builder = MOITWebBuilder(dependency: MockMOITWebDependencyImpl())
        let router = builder.build(
            withListener: self,
            path: self.items[indexPath.item]
        )
        self.webRouter = router
        
        router.load()
        router.interactable.activate()
        self.navigationController?.pushViewController(
            router.viewControllable.uiviewController,
            animated: true
        )
    }
}

// MARK: - MOITWebListener

extension MOITWebDemoRootViewController: MOITWebListener {
	func authorizationDidFinish(with signInResponse: SignInDomain.MOITSignInResponse) {
		
	}
	
    func shouldDetach(withPop: Bool) {
        guard let router = self.webRouter else { return }
        self.webRouter = nil
        router.interactable.deactivate()
        
        if withPop {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
