//
//  ViewController.swift
//
//  MOIT
//
//  Created by hyerin on .
//

import UIKit

import MOITParticipateUserInterfaceImpl

final class MOITParticipateUserInterfaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let viewController = InputParticipateCodeViewController()
		viewController.modalPresentationStyle = .fullScreen
		self.present(viewController, animated: true)
	}
}

