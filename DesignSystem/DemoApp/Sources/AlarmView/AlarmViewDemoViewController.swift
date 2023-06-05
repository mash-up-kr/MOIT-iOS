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
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
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
        self.scrollView.pin.all()
        self.scrollView.contentSize = contentView.frame.size
    }
    
    private func configureLayouts() {
        self.contentView.flex
            .alignItems(.center)
            .define { flex in
                
                flex.addItem(self.attendanceView())
                
                flex.addItem(self.출석률())
                    .marginTop(10)
                
                flex.addItem(self.penaltyView())
                    .marginTop(10)
                
                flex.addItem(self.penaltyView2())
                    .marginTop(10)
            }
        
        self.scrollView.flex
            .addItem(self.contentView)
        
        self.flexRootView.flex
            .define { flex in
                flex.addItem(self.scrollView)
            }
    }
    
    private func attendanceView() -> MOITAlarmView {
        let targetTime = Date.init(timeIntervalSinceNow: TimeInterval(60 * 3))
        print(Date.now)
        print(targetTime)
        return MOITAlarmView(
            type: .출석체크,
            studyName: "전자군단🤖"
        )
    }
    
    private func penaltyView() -> MOITAlarmView {
        MOITAlarmView(
            type: .벌금(amount: "9,999,999원"),
            studyName: "전자군단🤖✨☘️🗯️"
        )
    }
    
    private func penaltyView2() -> MOITAlarmView {
        MOITAlarmView(
            type: .벌금(amount: "12,000원"),
            studyName: "전자군단🤖✨☘️🗯️"
        )
    }
    
    private func 출석률() -> MOITAlarmView {
        MOITAlarmView(
            type: .출석률(percent: "99%"),
            studyName: "영일이삼사오육칠팔구십"
        )
    }
}
