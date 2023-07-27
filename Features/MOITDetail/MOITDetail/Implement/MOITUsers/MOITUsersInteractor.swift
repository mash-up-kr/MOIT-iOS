//
//  MOITUsersInteractor.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/07/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import MOITDetailDomain

protocol MOITUsersRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MOITUsersPresentable: Presentable {
    var listener: MOITUsersPresentableListener? { get set }
    func configure(users: [(imageURL: String, name: String)])
}

protocol MOITUsersListener: AnyObject {
  func didTapBackButton()
}

final class MOITUsersInteractor: PresentableInteractor<MOITUsersPresentable>,
                                 MOITUsersInteractable,
                                 MOITUsersPresentableListener {

    weak var router: MOITUsersRouting?
    weak var listener: MOITUsersListener?

    private let usecase: MOITUserUsecase
    private let moitID: String
    
    init(
        presenter: MOITUsersPresentable,
        usecase: MOITUserUsecase,
        moitID: String
    ) {
        self.moitID = moitID
        self.usecase = usecase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func viewDidLoad() {
        usecase.fetchMOITUsers(moitID: self.moitID)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] users in
                let usersViewModel = users.map { (imageURL: "\($0.profileImage)", name: $0.nickname) }
                self?.presenter.configure(users: usersViewModel)
            }, onError: { [weak self] error in
                print(error)
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    func didTapBackButton() {
        self.listener?.didTapBackButton()
    }
}
