//
//  MOITDetailViewModel.swift
//  MOITDetail
//
//  Created by 최혜린 on 2023/07/24.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public typealias MOITDetailInfoViewModels = [MOITDetailInfoViewModel]

public struct MOITDetailInfoViewModel {
	public let title: String
	public let description: String
	
	public init(
		title: String,
		description: String
	) {
		self.title = title
		self.description = description
	}
}
