//
//  ViewController.swift
//
//  MOIT
//
//  Created by hyerin on .
//

import UIKit

import MOITParticipateUserInterfaceImpl

fileprivate enum MOITParticipateType: String,
								   CaseIterable {
	case inputCode
	case particiaptionSuccess
}

final class MOITParticipateUserInterfaceViewController: UITableViewController {
	
	private var moitParticipateTypes: [MOITParticipateType] = MOITParticipateType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
		
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int
	) -> Int {
		moitParticipateTypes.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = self.moitParticipateTypes[indexPath.item].rawValue
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
		let moitParticipateType = self.moitParticipateTypes[indexPath.item]
		switch moitParticipateType {
		case .inputCode:
			self.navigationController?.pushViewController(InputParticipateCodeViewController(), animated: true)
		case .particiaptionSuccess:
			self.navigationController?.pushViewController(ParticipationSuccessViewController(), animated: true)
		}
	}
}

