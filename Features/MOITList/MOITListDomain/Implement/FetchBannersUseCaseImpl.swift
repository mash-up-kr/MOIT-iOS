//
//  FetchBannersUseCaseImpl.swift
//  MOITListDomain
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListDomain
import MOITListData

import RxSwift

public final class FetchBannersUseCaseImpl: FetchBannersUseCase {
    
    // MARK: - Properties
    
    private let repository: BannerRepository
    
    // MARK: - Initializers
    
    public init(repository: BannerRepository) {
        self.repository = repository
    }
    
    // MARK: - Methods
    
    public func execute() -> Single<[Banner]> {
        repository.fetchBannerList()
    }
}
