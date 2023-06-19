//
//  ViewController.swift
//
//  MOIT
//
//  Created by hyerin on .
//

import UIKit

import SignInUserInterfaceImpl

final class SignInUserInterfaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let viewController = LoggedOutViewController()
		viewController.modalPresentationStyle = .fullScreen
		self.present(viewController, animated: true)
	}
}

