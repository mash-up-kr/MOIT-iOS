//
//  BannerRepository.swift
//  MOITListData
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListDomain

import RxSwift

public protocol BannerRepository {
    
    func fetchBannerList() -> Single<[Banner]>
}
