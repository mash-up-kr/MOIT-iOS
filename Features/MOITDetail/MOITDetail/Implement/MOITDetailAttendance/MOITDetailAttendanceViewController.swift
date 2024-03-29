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

public protocol MOITDetailAttendancePresentableListener: AnyObject {
    func viewDidLoad()
    func didTapStudyView(id: String)
    func didTapSegment(at index: Int)
}

final class MOITDetailAttendanceViewController: UIViewController,
                                                MOITDetailAttendancePresentable,
                                                MOITDetailAttendanceViewControllable {
    
    private typealias StudyID = String
    
    private let disposeBag = DisposeBag()
    
    private let flexRootView = UIView()
    private let attendanceSegmentView = MOITSegmentPager()
    private let attendanceRatingView = MOITDetailAttendanceRatingView()
    
    // 전체출결
    private let allAttendanceView = UIView()
    private var seminarViews: OrderedDictionary<StudyID, MOITAttendanceStudyView> = .init()
    private let emptyStudyView = MOITAttendanceEmptyView()
    
    // 내출결
    private let myAttendanceView = UIView()
    private var myAttendances = [MOITList]()
    private let emptyMyAttendanceView = MOITAttendanceEmptyView()
    
    public weak var listener: MOITDetailAttendancePresentableListener?
    
    override func loadView() {
        self.view = flexRootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flexRootView.backgroundColor = .white
        
        self.configureLayouts()
        self.listener?.viewDidLoad()
        self.myAttendanceView.flex.display(.none)
        self.myAttendanceView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.flexRootView.pin.all()
        self.flexRootView.flex.layout()
    }
}

// MARK: - Private functions

extension MOITDetailAttendanceViewController {
    
    private func configureLayouts() {
        self.flexRootView.flex
            .define { flex in
                flex.addItem(self.attendanceSegmentView)
                    .marginHorizontal(20)
                
                // 전체출결
                flex.addItem(self.allAttendanceView)
                    .width(UIScreen.main.bounds.width)
                    .define { flex in
                        flex.addItem(self.emptyStudyView)
                            .height(400)
                        
                        flex.addItem(self.attendanceRatingView)
                            .marginHorizontal(20)
                            .height(78)
                            .marginTop(20)
                        
                        
                        self.seminarViews.elements.enumerated().forEach { index, element in
                            let seminarView = element.value
                            let seminarViewFlex = flex.addItem(seminarView)
                                .marginHorizontal(20)
                            
                            if index == self.seminarViews.elements.endIndex {
                                seminarViewFlex.marginBottom(20)
                            }
                        }
                    }
                
                // 내 출결
                flex.addItem(self.myAttendanceView)
                    .width(UIScreen.main.bounds.width)
                    .define { flex in
                        flex.addItem(self.emptyMyAttendanceView)
                            .height(400)
                        
                        self.myAttendances.enumerated().forEach { index, view in
                            let flex = flex.addItem(view)
                                .marginHorizontal(20)
                                .marginTop(20)
                            
                            if index == self.myAttendances.endIndex {
                                flex.marginBottom(20)
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
            
            self.attendanceSegmentView.rx.tapIndex
                .distinctUntilChanged()
                .bind(onNext: { [weak self] index in
                    self?.listener?.didTapSegment(at: index)
                })
                .disposed(by: self.disposeBag)
        }
    }
}

// MARK: - MOITDetailAttendancePresentable

extension MOITDetailAttendanceViewController {
    
    func updateAttendance(type: AttendanceTabType) {
        switch type {
        case .allAttendance:
            self.myAttendanceView.flex.display(.none)
            self.myAttendanceView.isHidden = true
            self.allAttendanceView.flex.display(.flex)
            self.allAttendanceView.isHidden = false
        case .myAttendance:
            self.myAttendanceView.flex.display(.flex)
            self.myAttendanceView.isHidden = false
            self.allAttendanceView.flex.display(.none)
            self.allAttendanceView.isHidden = true
        }
        self.flexRootView.setNeedsLayout()
    }
    
    func configureSegment(types: [AttendanceTabType]) {
        self.attendanceSegmentView.configurePages(pages: types.map(\.title))
    }
    
    func updateStudy(id: String, viewModel: MOITAttendanceStudyViewModel) {
        self.seminarViews[id]?.updateFold(viewModel.isFold)
        self.seminarViews[id]?.flex.markDirty()
        self.flexRootView.setNeedsLayout()
    }
    
    func configure(_ viewModel: MOITDetailAttendanceViewModel) {
        if viewModel.studies.isEmpty {
            self.emptyStudyView.isHidden = false
            self.emptyStudyView.flex.display(.flex)
            self.attendanceRatingView.flex.display(.none)
            self.attendanceRatingView.isHidden = true
        } else {
            self.emptyStudyView.isHidden = true
            self.emptyStudyView.flex.display(.none)
            self.attendanceRatingView.flex.display(.flex)
            self.attendanceRatingView.isHidden = false
        }
        self.emptyStudyView.flex.markDirty()
        
        viewModel.studies.forEach { studyID, studyViewModel in
            let studyView = MOITAttendanceStudyView()
            studyView.configure(viewModel: studyViewModel)
            self.seminarViews[studyID] = studyView
            studyView.flex.markDirty()
        }
        
        self.myAttendances = viewModel.myAttendances.map { viewModel in
            let view = MOITList(
                type: .myAttend,
                imageType: ProfileImageType(rawValue: viewModel.profileImageURL),
                title: viewModel.tilte,
                detail: viewModel.detail,
                chipType: viewModel.attendance.toChipeType
            )
            view.flex.markDirty()
            return view
        }
        
        if viewModel.myAttendances.isEmpty {
            emptyMyAttendanceView.isHidden = false
            emptyMyAttendanceView.flex.display(.flex)
        } else {
            emptyMyAttendanceView.isHidden = true
            emptyMyAttendanceView.flex.display(.none)
        }
        
        self.attendanceRatingView.absentRating = viewModel.absenceRate
        self.attendanceRatingView.attendanceRating = viewModel.attendanceRate
        self.attendanceRatingView.lateRating = viewModel.lateRate
        
        self.attendanceRatingView.flex.markDirty()
        self.allAttendanceView.flex.markDirty()
        self.myAttendanceView.flex.markDirty()
        self.view.setNeedsLayout()
        self.configureLayouts()
        self.bind()
    }
}
