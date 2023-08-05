//
//  FetchMoitListUseCaseImpl.swift
//  MOITListDomain
//
//  Created by kimchansoo on 2023/07/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

import MOITListData
import MOITListDomain

public final class FetchMoitListUseCaseImpl: FetchMoitListUseCase {
    
    // MARK: - Properties
    private let moitRepository: MOITRepository
    
    // MARK: - Initializers
    public init(
        moitRepository: MOITRepository
    ) {
        self.moitRepository = moitRepository
    }
    
    // MARK: - Methods
    public func execute() -> Single<[MOIT]> {
        moitRepository.fetchMOITList()
            .map { _ in return [] }
    }
}
