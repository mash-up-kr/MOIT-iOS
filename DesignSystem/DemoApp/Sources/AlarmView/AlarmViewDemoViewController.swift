//
//  AlarmViewDemoViewController.swift
//  DesignSystem
//
//  Created by 송서영 on 2023/06/04.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout
import DesignSystem
import ResourceKit

final class AlarmViewDemoViewController: UIViewController {
    
    private let flexRootView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.flexRootView)
        self.configureLayouts()
        self.view.backgroundColor = .white
        self.navigationController?.navigationItem.title = "MOITAlarmView"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout()
    }
    
    private func configureLayouts() {
        self.flexRootView.flex
            .alignItems(.center)
            .define { flex in
                flex.addItem(self.attendanceView())
                
                flex.addItem(self.penaltyView())
                    .marginTop(10)
            }
    }
    
    private func attendanceView() -> MOITAlarmView {
        let targetTime = Date.init(timeIntervalSinceNow: TimeInterval(60 * 3))
        print(Date.now)
        print(targetTime)
        return MOITAlarmView(
            type: .attendance,
            studyName: "전자군단🤖"
        )
    }
    
    private func penaltyView() -> MOITAlarmView {
        MOITAlarmView(
            type: .penalty(amount: "9,999,999원"),
            studyName: "전자군단🤖✨☘️🗯️"
        )
    }
    
    private func penaltyView2() -> MOITAlarmView {
        MOITAlarmView(
            type: .penalty(amount: "12,000원"),
            studyName: "전자군단🤖✨☘️🗯️"
        )
    }
}
