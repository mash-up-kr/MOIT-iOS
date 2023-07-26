//
//  UIViewController+.swift
//  Utils
//
//  Created by 김찬수 on 2023/06/15.
//

import UIKit

public extension UIViewController {
    
    func hideKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        // 기본값이 true이면 제스쳐 발동시 터치 이벤트가 뷰로 전달x
        // 즉 제스쳐가 동작하면 뷰의 터치이벤트는 발생하지 않는것 false면 둘 다 작동한다는 뜻
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
	
	func showAlert(
		title: String? = nil,
		message: String,
		type: AlertActionType,
		okActionTitle: String = "확인",
		okActionHandler: (() -> Void)? = nil,
		cancelActionTitle: String = "취소",
		cancelActionHandler: (() -> Void)? = nil
	) {
		let alertController = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert
		)
			
		if type == .double {
			let cancelAction = UIAlertAction(title: cancelActionTitle, style: .default) { _ in
				if let cancelActionHandler = cancelActionHandler {
					cancelActionHandler()
				}
			}
			alertController.addAction(cancelAction)
		}
		
		let okAction = UIAlertAction(title: okActionTitle, style: .default) { _ in
			if let okActionHandler = okActionHandler {
				okActionHandler()
			}
		}
		
		alertController.addAction(okAction)
		self.present(alertController, animated: true, completion: nil)
	}
}

extension UIViewController {
	public enum AlertActionType {
		case single
		case double
	}
}
