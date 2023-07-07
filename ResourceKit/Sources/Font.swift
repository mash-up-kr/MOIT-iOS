//
//  Font.swift
//  ResourceKit
//
//  Created by kimchansoo on 2023/06/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

// TODO: extension 메서드 위치 이동 후 Foundation으로 변경 필요
import UIKit

extension ResourceKitFontFamily {
    public static let h1 = Pretendard.bold.font(size: 36)
    public static let h2 = Pretendard.bold.font(size: 32)
    public static let h3 = Pretendard.semiBold.font(size: 24)
    public static let h4 = Pretendard.semiBold.font(size: 20)
    public static let h5 = Pretendard.semiBold.font(size: 18)
    public static let h6 = Pretendard.semiBold.font(size: 16)
    public static let p1 = Pretendard.medium.font(size: 16)
    public static let p2 = Pretendard.medium.font(size: 14)
    public static let p3 = Pretendard.regular.font(size: 14)
    public static let caption = Pretendard.medium.font(size: 12)
	
	public static func lineHeight(of font: ResourceKitFontConvertible.Font) -> CGFloat {
		if font == h1 { return 50 }
		else if [h2, h4].contains(where: { $0 == font }) { return 32 }
		else if font == h3 { return 36 }
		else if font == h5 { return 27}
		else if [h6, p1].contains(where: { $0 == font }) { return 23 }
		else if [p2, p3].contains(where: { $0 == font }) { return 22 }
		else if font == caption { return 18 }
		else { return 0 }
	}
}
