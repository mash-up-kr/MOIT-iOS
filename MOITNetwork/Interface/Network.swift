//
//  Network.swift
//  MOITNetwork
//
//  Created by 최혜린 on 2023/05/15.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation
import RxSwift

public protocol Network {
	func request<E: Requestable>(with endpoint: E) -> Single<E.Response>
}
