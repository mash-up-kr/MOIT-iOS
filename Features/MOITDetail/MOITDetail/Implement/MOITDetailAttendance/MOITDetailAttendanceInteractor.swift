//
//  MOITDetailAttendanceInteractor.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import MOITDetailDomain
import Collections
import MOITDetail
import TokenManagerImpl

protocol MOITDetailAttendanceRouting: ViewableRouting {
}

protocol MOITDetailAttendancePresentable: Presentable {
    var listener: MOITDetailAttendancePresentableListener? { get set }
    func configure(_ viewModel: MOITDetailAttendanceViewModel)
    func updateStudy(id: String, viewModel: MOITAttendanceStudyViewModel)
    func configureSegment(types: [AttendanceTabType])
    func updateAttendance(type: AttendanceTabType)
}

protocol MOITDetailAttendanceListener: AnyObject {
    func didTapStudyView()
    func didTapSegment()
}

final class MOITDetailAttendanceInteractor: PresentableInteractor<MOITDetailAttendancePresentable>,
                                            MOITDetailAttendanceInteractable,
                                            MOITDetailAttendancePresentableListener {
    
    private typealias AttendanceType = MOITDetailAttendanceViewModel.AttendanceViewModel.Attendance
    private typealias AttendanceViewModel = MOITDetailAttendanceViewModel.AttendanceViewModel
    private typealias StudyID = String
    private typealias StudyEntity = MOITAllAttendanceEntity.Study
    private typealias AttendanceEntity = MOITAllAttendanceEntity.Study.Attendance
    
    weak var router: MOITDetailAttendanceRouting?
    weak var listener: MOITDetailAttendanceListener?
    
    private let moitID: StudyID
    private let moitAllAttendanceUsecase: MOITAllAttendanceUsecase
    private var viewModel: MOITDetailAttendanceViewModel?
    private let attendanceTabs: [AttendanceTabType]
    private let userID: String
    
    init(
        presenter: MOITDetailAttendancePresentable,
        moitID: String,
        moitAllAttendanceUsecase: MOITAllAttendanceUsecase,
        attendanceTabs: [AttendanceTabType],
        userID: String
    ) {
        self.userID = userID
        self.attendanceTabs = attendanceTabs
        self.moitID = moitID
        self.moitAllAttendanceUsecase = moitAllAttendanceUsecase
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    deinit { debugPrint("\(self) deinit") }
}

// MARK: - MOITDetailAttendancePresentableListener

extension MOITDetailAttendanceInteractor {
    
    func didTapStudyView(id: String) {
        self.viewModel?.studies[id]?.toggleFold()
        guard let studyViewModel = self.viewModel?.studies[id] else { return }
        self.presenter.updateStudy(id: id, viewModel: studyViewModel)
        self.listener?.didTapStudyView()
    }
    
    private func fetch() {
        guard let myUserId = TokenManagerImpl().get(key: .userID) else { return }
        moitAllAttendanceUsecase.fetchAllAttendance(moitID: self.moitID, myID: myUserId)
            .asObservable()
            .do(onNext: { [weak self] all, rate, my in
                print("😆",rate)
                print("--------------------------------------------------------------------------------")
                print("😆",my)
            })
        .compactMap { [weak self] allAttendances, attendanceRate, myAttendances -> MOITDetailAttendanceViewModel? in
            guard let self else { return nil }
            var studiesDictionary = OrderedDictionary<StudyID, MOITAttendanceStudyViewModel>()
            var attendancesDictionary = OrderedDictionary<StudyID, [AttendanceViewModel]>()

            allAttendances.studies.forEach { [weak self] study in
                studiesDictionary[study.studyID] = self?.configureStudyViewModel(study)
                attendancesDictionary[study.studyID] = self?.configureAttendanceViewModel(study.attendances)
            }

            return MOITDetailAttendanceViewModel(
                studies: studiesDictionary,
                attendances: attendancesDictionary,
                myAttendances: self.configureAttendanceViewModel(myAttendances),
                attendanceRate: attendanceRate.attendanceRate,
                lateRate: attendanceRate.lateRate,
                absenceRate: attendanceRate.absentRate
            )
        }
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { [weak self] viewModel in
            self?.viewModel = viewModel
            self?.presenter.configure(viewModel)
        }, onError: { error in
            print(error, "error를 잡았따.")
        })
        .disposeOnDeactivate(interactor: self)
    }
    
    func viewDidLoad() {
        self.presenter.configureSegment(types: self.attendanceTabs)
        self.fetch()
    }
    
    func didTapSegment(at index: Int) {
        guard let type = self.attendanceTabs[safe: index] else { return }
        self.presenter.updateAttendance(type: type)
        self.listener?.didTapSegment()
    }
}

// MARK: - Private functions
extension MOITDetailAttendanceInteractor {
    
    private func configureStudyViewModel(_ study: StudyEntity) -> MOITAttendanceStudyViewModel {
        MOITAttendanceStudyViewModel(
            studyID: study.studyID,
            name: study.studyName,
            date: study.studyDate,
            attendances: self.configureAttendanceViewModel(study.attendances)
        )
    }
    
    private func configureAttendanceViewModel(_ attendances: [AttendanceEntity]) -> [AttendanceViewModel] {
        attendances.map { attendance in
            AttendanceViewModel(
                profileImageURL: attendance.profileImage,
                tilte: attendance.nickname,
                detail: attendance.attendanceAt,
                attendance: self.convertToChip(attendance.status)
            )
        }
    }
    
    private func convertToChip(_ attendance: AttendanceStatus) -> AttendanceType {
        switch attendance {
        case .ABSENCE: return .absent
        case .ATTENDANCE: return .attend
        case .LATE: return .late
        case .UNDECIDED: return .attend
        }
    }
}
