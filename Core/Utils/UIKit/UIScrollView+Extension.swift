//
//  UIScrollView+Extension.swift
//  Utils
//
//  Created by 최혜린 on 2023/07/07.
//

import UIKit

public extension UIScrollView {
	func scrollToRight() {
		let rightOffset = CGPoint(x: contentInset.right + bounds.width, y: 0)
		setContentOffset(rightOffset, animated: true)
	}
	
	func scrollToLeft() {
		let leftOffset = CGPoint(x: -contentInset.left, y: 0)
		setContentOffset(leftOffset, animated: true)
	}
}
