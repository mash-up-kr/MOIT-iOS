//
//  MOITRepository.swift
//  MOITListData
//
//  Created by kimchansoo on 2023/07/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListDomain

import RxSwift

public protocol MOITRepository {
    
    func fetchMOITList() -> Single<[MOIT]>
    func deleteMoit(id: Int) -> Single<Void>
}
