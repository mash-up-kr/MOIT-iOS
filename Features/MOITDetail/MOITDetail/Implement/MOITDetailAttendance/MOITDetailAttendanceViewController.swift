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
import Collections

struct MOITDetailAttendanceViewModel {
    struct AttendanceViewModel {
        enum Attendance {
            case attend
            case late
            case absent
            
            var toChipeType: MOITChipType {
                switch self {
                case .absent: return .absent
                case .late: return .late
                case .attend: return .attend
                }
            }
        }
        let profileImageURL: String
        let tilte: String
        let detail: String
        let attendance: Attendance
    }
    var studies: OrderedDictionary<String, MOITAttendanceStudyViewModel>
    let attendances: OrderedDictionary<String, [AttendanceViewModel]>
}
public protocol MOITDetailAttendancePresentableListener: AnyObject {
    func viewDidLoad()
    func didTapStudyView(id: String)
}

final class MOITDetailAttendanceViewController: UIViewController,
                                                MOITDetailAttendancePresentable,
                                                MOITDetailAttendanceViewControllable {
    
    private typealias StudyID = String
    
    private let disposeBag = DisposeBag()
    private let flexRootView = UIView()
    private let attendanceSegmentView = MOITSegmentPager(pages: ["전체출결", "내출결"])
    private let attendanceRatingView = MOITDetailAttendanceRatingView()
    private var seminarViews: OrderedDictionary<StudyID, MOITAttendanceStudyView> = .init()
    private var attendanceViews: OrderedDictionary<StudyID, [MOITList]> = .init()
    public weak var listener: MOITDetailAttendancePresentableListener?
    private var attendanceRating: CGFloat = 0.7
    private var lateRating: CGFloat = 0.2
    private var absentRating: CGFloat = 0.1
    
    override func loadView() {
        self.view = flexRootView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🙇‍♀️",#function, #file)
        self.flexRootView.backgroundColor = .white
        
        self.configureLayouts()
        self.listener?.viewDidLoad()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("🙇‍♀️", #function, #file)
        self.flexRootView.pin.all(self.view.pin.safeArea)
        self.flexRootView.flex.layout()
    }
}

// MARK: - Private functions

extension MOITDetailAttendanceViewController {
    
    private func configureLayouts() {
        self.flexRootView.flex
            .alignItems(.stretch)
            .define { flex in
                flex.addItem(self.attendanceSegmentView)
                    .marginHorizontal(20)
                
                flex.addItem(self.attendanceRatingView)
                    .marginHorizontal(20)
                    .height(78)
                    .marginTop(20)
                
                self.seminarViews.elements.forEach { key, seminarView in
                    flex.addItem(seminarView)
                        .marginHorizontal(20)
                    
                    let attendances = self.attendanceViews[key] ?? []
                    attendances.enumerated().forEach { index, view in
                        view.isHidden = true
                        let flex = flex.addItem(view)
                            .marginHorizontal(20)
                            .display(.none)
                        if index != 0 {
                            flex.marginTop(20)
                        }
                    }
                }
            }
    }
    
    private func bind() {
        self.seminarViews.forEach { [weak self] studyID, value in
            guard let self = self else { return }
            value.rx.tapGesture()
                .when(.recognized)
                .throttle(.milliseconds(400), latest: false, scheduler: MainScheduler.instance)
                .bind(onNext: { [weak self] _ in
                    self?.listener?.didTapStudyView(id: studyID)
                })
                .disposed(by: self.disposeBag)
        }
    }
}

// MARK: - MOITDetailAttendancePresentable

extension MOITDetailAttendanceViewController {
    
    func updateStudy(id: String, viewModel: MOITAttendanceStudyViewModel) {
        self.attendanceViews[id]?.forEach { attendance in
            switch viewModel.isFold {
            case .fold:
                attendance.flex.display(.none)
                attendance.isHidden = true
            case .unfold:
                attendance.flex.display(.flex)
                attendance.isHidden = false
            }
            attendance.flex.markDirty()
        }
        self.seminarViews[id]?.configure(viewModel: viewModel)
        self.seminarViews[id]?.flex.markDirty()
        self.flexRootView.setNeedsLayout()
    }
    
    func configure(_ viewModel: MOITDetailAttendanceViewModel) {
        viewModel.studies.forEach { studyID, studyViewModel in
            let studyView = MOITAttendanceStudyView()
            studyView.configure(viewModel: studyViewModel)
            self.seminarViews[studyID] = studyView
            studyView.flex.markDirty()
        }
        viewModel.attendances.forEach { studyID, attendanceViewModels in
            let views = attendanceViewModels.map { viewModel in
                let view = MOITList(
                    type: .allAttend,
                    imageUrlString: viewModel.profileImageURL,
                    title: viewModel.tilte,
                    detail: viewModel.detail,
                    chipType: viewModel.attendance.toChipeType
                )
                view.flex.markDirty()
                return view
            }
            self.attendanceViews[studyID] = views
        }
        
        self.attendanceRatingView.absentRating = self.absentRating
        self.attendanceRatingView.attendanceRating = self.attendanceRating
        self.attendanceRatingView.lateRating = self.lateRating
        
        self.attendanceRatingView.flex.markDirty()
        
        self.configureLayouts()
        self.bind()
    }
}
