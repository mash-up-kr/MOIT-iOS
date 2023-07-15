//
//  RootViewController.swift
//  App
//
//  Created by 송서영 on 2023/05/22.
//

import RIBs
import RxSwift
import UIKit
import FlexLayout
import PinLayout
import RxCocoa

protocol RootPresentableListener: AnyObject {
    func didTapCreateButton()
    func didTapAttendanceButton()
    func didTapModifyButton(id: String)
    func didTapAttendanceResultButton()
}

final class RootViewController: UIViewController,
                                RootPresentable,
                                RootViewControllable {
    
    weak var listener: RootPresentableListener?
    private let flexrootView = UIView()
    private let moitCreateButton = UIButton()
    private let attendancesButton = UIButton()
    private let modifyTextField = UITextField()
    private let modifyButton = UIButton()
    private let attendanceResultButton = UIButton()
    private let label = UILabel()
    private let tokenLabel = UILabel()
    private let diseposeBag = DisposeBag()
    
    override func loadView() {
        self.view = flexrootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flexrootView.backgroundColor = .white
        self.label.text = "웹분들 여기예용 😲💖 화이팅! 전자군단🤖"
        self.tokenLabel.numberOfLines = 0
        self.tokenLabel.text = """
토큰은 아래를 넘깁니다.
Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqd3QtdXNlci1kZWZhdWx0IiwiYXVkIjoiYXV0aDB8YWJjQG5hdmVyLmNvbXw3fGRlZmF1bHQiLCJpc3MiOiJodHRwczovL2dpdGh1Yi5jb20vbWFzaC11cC1rci9NT0lULWJhY2tlbmQiLCJpYXQiOjE2ODg4ODkyOTMsImV4cCI6MTY5MTQ4MTI5MywiaW5mbyI6eyJpZCI6NywicHJvdmlkZXJVbmlxdWVLZXkiOiJhdXRoMHxhYmNAbmF2ZXIuY29tIiwibmlja25hbWUiOiJkZWZhdWx0IiwicHJvZmlsZUltYWdlIjowLCJlbWFpbCI6ImFiY0BuYXZlci5jb20iLCJyb2xlcyI6WyJVU0VSIl19fQ.o9WjiGqNOZSkHGDKQ54b50TUEy-oWvPo1-5Egjw1HXc
"""
        self.label.textAlignment = .center
        modifyTextField.layer.borderColor = UIColor.black.cgColor
        modifyTextField.layer.borderWidth = 1
        moitCreateButton.setTitle("모잇생성 진입점", for: .normal)
        attendancesButton.setTitle("출석하기 진입점", for: .normal)
        modifyButton.setTitle("모잇 수정하기 진입점(아이디안적을시에2번으로수정됨)", for: .normal)
        attendanceResultButton.setTitle("출석결과 진입점", for: .normal)
        moitCreateButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.listener?.didTapCreateButton()
            })
            .disposed(by: diseposeBag)
        
        attendancesButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.listener?.didTapAttendanceButton()
            })
            .disposed(by: diseposeBag)
        
        modifyButton.rx.tap
            .bind(onNext: { [weak self] _ in
                let id = self?.modifyTextField.text ?? "2"
                self?.listener?.didTapModifyButton(id: id)
            })
            .disposed(by: self.diseposeBag)
        
        attendanceResultButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.listener?.didTapAttendanceResultButton()
            })
            .disposed(by: self.diseposeBag)
        
        moitCreateButton.setTitleColor(.black, for: .normal)
        attendancesButton.setTitleColor(.black, for: .normal)
        modifyButton.setTitleColor(.black, for: .normal)
        attendanceResultButton.setTitleColor(.black, for: .normal)
        define()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flexrootView.pin.all()
        self.flexrootView.flex.layout()
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    private func define() {
        self.flexrootView.flex.define { flex in
            flex.addItem(self.label)
                .marginTop(100)
            flex.addItem()
                .backgroundColor(.black)
                .height(5)
            flex.addItem(tokenLabel)
                .marginTop(10)
            flex.addItem()
                .backgroundColor(.black)
                .height(5)
            flex.addItem(moitCreateButton)
                .marginTop(20)
            flex.addItem(attendancesButton)
                .marginTop(20)
            flex.addItem(modifyTextField)
                .marginTop(20)
                .marginHorizontal(50)
            flex.addItem(modifyButton)
                .marginTop(20)
            flex.addItem(attendanceResultButton)
                .marginTop(20)
        }
    }
}
