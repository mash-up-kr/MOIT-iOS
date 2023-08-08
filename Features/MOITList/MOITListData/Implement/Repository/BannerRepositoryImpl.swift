//
//  BannerRepositoryImpl.swift
//  MOITListData
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListDomain
import MOITNetwork
import MOITListData

import RxSwift

public final class BannerRepositoryImpl: BannerRepository {
    
    // MARK: - Properties
    
    private let network: Network
    
    // MARK: - Initializers
    public init(network: Network) {
        self.network = network
    }
    
    // MARK: - Methods
    public func fetchBannerList() -> Single<[Banner]> {
        let endpoint = BannerEndpoint.fetchBannerList()
        return network.request(with: endpoint)
			.compactMap { bannerDto -> [Banner]? in
				let attendanceBanners = bannerDto?.attendanceBanners.map { $0.toBanner() }
				let fineBanners = bannerDto?.fineBanners.map { $0.toBanner() }
				let defaultBanners = bannerDto?.defaultBanners.map { $0.toBanner() }
				
				if let attendanceBanners, let fineBanners, let defaultBanners {
					return attendanceBanners + fineBanners + defaultBanners
				} else {
					return nil
				}
			}.asObservable().asSingle()
    }
}
