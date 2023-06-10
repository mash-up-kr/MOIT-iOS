//
//  MOITDetailAttendanceViewController.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import PinLayout
import FlexLayout
import RxCocoa
import ResourceKit
import DesignSystem

public protocol MOITDetailAttendancePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

// TODO: 임시로 public
public final class MOITDetailAttendanceViewController: UIViewController,
                                                MOITDetailAttendancePresentable,
                                                MOITDetailAttendanceViewControllable {
    private let flexRootView = UIView()
    private let attendanceSegmentView = MOITSegmentPager(pages: ["전체출결", "내출결"])
    
    public weak var listener: MOITDetailAttendancePresentableListener?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, #file)
        self.view.backgroundColor = .white
        self.flexRootView.backgroundColor = .white
        self.configureLayouts()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function, #file)
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout()
    }
    
    private func configureLayouts() {
        self.view.addSubview(self.flexRootView)
        self.flexRootView.flex
            .alignItems(.stretch)
            .define { flex in
                flex.addItem(self.attendanceSegmentView)
                    .marginHorizontal(20)
            }
    }
}
