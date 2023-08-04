//
//  MOITRepository.swift
//  MOITListData
//
//  Created by kimchansoo on 2023/07/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

import MOITListData
import MOITListDomain
import MOITNetwork

public final class MOITRepositoryImpl: MOITRepository {

    
    // MARK: - UI
    
    // MARK: - Properties
    private let network: Network
    
    // MARK: - Initializers
    public init(network: Network) {
        self.network = network
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    public func fetchMOITList() -> Single<[MOIT]> {
        network.request(
			with: FetchMOITListEndpoint.fetchMOITList()
        )
        .map { $0.moits.map { $0.toMOIT() } }
    }
    
    public func deleteMoit(id: Int) -> Single<Void> {
        fatalError()
    }
}
