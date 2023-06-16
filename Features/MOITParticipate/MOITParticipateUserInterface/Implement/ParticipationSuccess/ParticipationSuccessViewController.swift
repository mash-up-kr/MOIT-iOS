//
//  ParticipationSuccessViewController.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/16.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol ParticipationSuccessPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ParticipationSuccessViewController: UIViewController, ParticipationSuccessPresentable, ParticipationSuccessViewControllable {

    weak var listener: ParticipationSuccessPresentableListener?
}
