//
//  String+Extension.swift
//  MOITFoundation
//
//  Created by 최혜린 on 2023/06/20.
//

import UIKit

extension String {
	public func addParagraphStyle(
		lineSpacing: CGFloat,
		alignment: NSTextAlignment,
		font: UIFont,
		textColor: UIColor
	) -> NSMutableAttributedString {
		
		let currentText = NSMutableAttributedString(string: self)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = lineSpacing
		paragraphStyle.alignment = alignment
		
		let attributes: [NSAttributedString.Key : Any] = [
			.paragraphStyle : paragraphStyle,
			.font: font,
			.foregroundColor: textColor
		]
		currentText.addAttributes(attributes, range: NSRange(location: 0, length: currentText.length))
		
		return currentText
	}
}
