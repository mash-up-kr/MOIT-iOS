//
//  FineRepository.swift
//  MOITListData
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListDomain

import RxSwift

public protocol FineRepository {
    
    func fetchFine(moitId: Int) -> Single<Fine>
}
