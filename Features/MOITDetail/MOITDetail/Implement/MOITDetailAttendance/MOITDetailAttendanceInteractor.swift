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

protocol MOITDetailAttendanceRouting: ViewableRouting {
}

protocol MOITDetailAttendancePresentable: Presentable {
    var listener: MOITDetailAttendancePresentableListener? { get set }
    func configure(_ viewModel: MOITDetailAttendanceViewModel)
    func updateStudy(id: String, viewModel: MOITAttendanceStudyViewModel)
}

protocol MOITDetailAttendanceListener: AnyObject {
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
    
    init(
        presenter: MOITDetailAttendancePresentable,
        moitID: String,
        moitAllAttendanceUsecase: MOITAllAttendanceUsecase
    ) {
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
    }
    
    func viewDidLoad() {
        moitAllAttendanceUsecase.fetchAllAttendance(moitID: self.moitID)
            .compactMap { [weak self] entity -> MOITDetailAttendanceViewModel? in
                var studiesDictionary = OrderedDictionary<StudyID, MOITAttendanceStudyViewModel>()
                var attendancesDictionary = OrderedDictionary<StudyID, [AttendanceViewModel]>()
                
                entity.studies.forEach { [weak self] study in
                    studiesDictionary[study.studyID] = self?.configureStudyViewModel(study)
                    attendancesDictionary[study.studyID] = self?.configureAttendanceViewModel(study.attendances)
                }
                
                return MOITDetailAttendanceViewModel(
                    studies: studiesDictionary,
                    attendances: attendancesDictionary
                )
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] viewModel in
                self?.viewModel = viewModel
                self?.presenter.configure(viewModel)
            }, onError: { error in
                print(error, "error를 잡았따.")
            })
            .disposeOnDeactivate(interactor: self)
    }
}

// MARK: - Private functions
extension MOITDetailAttendanceInteractor {
    
    private func configureStudyViewModel(_ study: StudyEntity) -> MOITAttendanceStudyViewModel {
        MOITAttendanceStudyViewModel(
            studyID: study.studyID,
            name: study.studyName,
            date: study.studyDate
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
    
    private func convertToChip(_ attendance: AttendanceStatus) ->  AttendanceType {
        switch attendance {
        case .ABSENCE: return .absent
        case .ATTENDANCE: return .attend
        case .LATE: return .late
        case .UNDECIDED: return .attend
        }
    }
}
