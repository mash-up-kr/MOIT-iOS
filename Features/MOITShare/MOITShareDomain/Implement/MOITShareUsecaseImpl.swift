//
//  MOITShareUsecaseImpl.swift
//  MOITShareDomainImpl
//
//  Created by 송서영 on 2023/07/27.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITShareDomain
import RxSwift
import UIKit

public struct MOITShareUsecaseImpl: MOITShareUsecase {
    
    public init() { }
    
    public func copyLink(_ link: String) -> Single<Void> {
        Observable<Void>.create { observer in
            UIPasteboard.general.string = link
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create()
        }.asSingle()
    }
}
