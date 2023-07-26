//
//  ShareViewController.swift
//  ShareImpl
//
//  Created by 송서영 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import DesignSystem
import ResourceKit
import PinLayout
import FlexLayout

protocol SharePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

public final class ShareViewController: BottomSheetViewController,
                                 SharePresentable,
                                ShareViewControllable {

    weak var listener: SharePresentableListener?
    
    public override init(contentView: UIView) {
        super.init(contentView: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
