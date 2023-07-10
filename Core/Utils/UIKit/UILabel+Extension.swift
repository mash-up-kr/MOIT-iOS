//
//  UILabel+Extension.swift
//  Utils
//
//  Created by 최혜린 on 2023/07/03.
//

import UIKit

import ResourceKit

public extension UILabel {
	func setTextWithParagraphStyle(
		text: String,
		alignment: NSTextAlignment = .left,
		font: ResourceKitFontConvertible.Font,
		textColor: UIColor
	) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = alignment
		
		let fontHeight = ResourceKitFontFamily.lineHeight(of: font)
		paragraphStyle.maximumLineHeight = fontHeight
		paragraphStyle.minimumLineHeight = fontHeight
		
		let attributes: [NSAttributedString.Key : Any] = [
			.paragraphStyle : paragraphStyle,
			.font: font,
			.foregroundColor: textColor,
			.baselineOffset: (fontHeight - font.lineHeight) / 4
		]
		
		debugPrint(font.lineHeight)
		
		let attrString = NSAttributedString(string: text,
											attributes: attributes)
		self.attributedText = attrString
	}
}
