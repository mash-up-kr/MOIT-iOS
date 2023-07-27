//
//  DeleteMOITUseCase.swift
//  MOITListDomain
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import RxSwift

public protocol DeleteMOITUseCase {
    
    func execute(moitId: Int) -> Observable<Void>
}
