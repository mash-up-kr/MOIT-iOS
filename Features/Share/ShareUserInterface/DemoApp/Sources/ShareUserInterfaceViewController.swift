//
//  ViewController.swift
//
//  MOIT
//
//  Created by 송서영 on .
//

import UIKit
import ShareImpl

final class ShareUserInterfaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = ShareViewController(
            contentView: MOITShareView(invitationCode: "전ㅈr군단")
        )
                                     
        self.present(vc, animated: true)
    }
}

