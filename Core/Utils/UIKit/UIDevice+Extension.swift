//
//  UIDevice+Extension.swift
//  Utils
//
//  Created by 최혜린 on 2023/07/03.
//

import UIKit

extension UIDevice {
	static var safeAreaBottomPadding: CGFloat {
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
		   let window = windowScene.windows.first else {
			return 0
		}
		
		let bottomPadding = window.safeAreaInsets.bottom
		return bottomPadding
	}
}
