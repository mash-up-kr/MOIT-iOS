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
    
    public var baseURL: URL? {
        return URL(string: "http://moit-backend-eb-env.eba-qtcnkjjy.ap-northeast-2.elasticbeanstalk.com") ?? URL(fileReferenceLiteralResourceName: "")
    }
    
    public var path: String {
        return "/api/v1/moit"
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
