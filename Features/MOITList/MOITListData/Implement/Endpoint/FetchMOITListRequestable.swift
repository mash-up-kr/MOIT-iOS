//
//  MOITRequestable.swift
//  MOITListData
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITNetwork
import MOITListData

struct FetchMOITListRequestable: Requestable {
    
    public typealias Response = MOITListDTO
    
    // MARK: - Properties
    
    public var path: String {
        return "moit"
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var headers: HTTPHeaders {
        return [:]
    }
    
    public var parameters: HTTPRequestParameter? {
        return nil
    }
    
    // mark: - Initializers
    init() {
    
    }
}
