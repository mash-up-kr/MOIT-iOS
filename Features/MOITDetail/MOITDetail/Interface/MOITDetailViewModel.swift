//
//  MOITDetailViewModel.swift
//  MOITDetail
//
//  Created by 최혜린 on 2023/07/24.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public typealias MOITDetailInfoViewModels = [MOITDetailInfoViewModel]

public struct MOITDetailProfileInfoViewModel {
	public let moitID: Int
	public let profileInfo: MOITProfileInfoViewModel
	public let detailInfos: MOITDetailInfoViewModels
	
	public init(
		moitID: Int,
		profileInfo: MOITProfileInfoViewModel,
		detailInfos: MOITDetailInfoViewModels
	) {
		self.moitID = moitID
		self.profileInfo = profileInfo
		self.detailInfos = detailInfos
	}
}

public struct MOITProfileInfoViewModel {
	public let imageUrl: String?
	public let moitName: String
	
	public init(
		imageUrl: String?,
		moitName: String
	) {
		self.imageUrl = imageUrl
		self.moitName = moitName
	}
}

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
