//
//  FineRepositoryImpl.swift
//  MOITListDataImpl
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

import MOITListData
import MOITListDomain
import MOITNetwork

final class FineRepositoryImpl: FineRepository {
    
    // MARK: - Properties
    private let network: Network
    
    // MARK: - Initializers
    public init(network: Network) {
        self.network = network
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    func fetchFine(moitId: Int) -> Single<Fine> {
        fatalError()
    }
}
