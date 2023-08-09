//
//  ShareViewController.swift
//  ShareImpl
//
//  Created by 송서영 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import DesignSystem
import ResourceKit
import PinLayout
import FlexLayout

protocol SharePresentableListener: AnyObject {
    func didTapLinkCopyButton()
    func didTapDimmedView()
    func didTapShareButton()
    func didShareSuccess()
    func didTapAlertOkAction()
}

public final class ShareViewController: BottomSheetViewController,
                                        SharePresentable,
                                        ShareViewControllable {
    
    private var contentview: MOITShareView?
    private let disposeBag = DisposeBag()
    weak var listener: SharePresentableListener?
    
    public override init(contentView: UIView) {
        if let contentView = contentView as? MOITShareView {
            self.contentview = contentView
        }
        
        super.init(contentView: contentView)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        contentview?.rx.didTapLinkCopyButton
            .bind(onNext: { [weak self] in
                self?.listener?.didTapLinkCopyButton()
            })
            .disposed(by: self.disposeBag)
        
        self.rx.didTapDimmedView
            .bind(onNext: { [weak self] in
                self?.listener?.didTapDimmedView()
            })
            .disposed(by: self.disposeBag)
        
        contentview?.rx.didTapShareButton
            .bind(onNext: { [weak self] in
                self?.listener?.didTapShareButton()
            })
            .disposed(by: self.disposeBag)
    }
    
    func presentActivity(code: String) {
        self.presentUIActivity(item: code)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "확인",
            style: .default
        ) { [weak self] _ in
            self?.listener?.didTapAlertOkAction()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    private func presentUIActivity(item: String) {
        let viewController = UIActivityViewController(
            activityItems: [
                """
            MOIT쓰니 스터디 관리 왜 이렇게 편해잇!
            여기로 당장 모잇 👉 \(item)
            """
            ],
            applicationActivities: nil
        )
        viewController.excludedActivityTypes = [
            .assignToContact,
            .print,
            .postToWeibo,
            .postToVimeo,
            .postToTencentWeibo,
            .postToFlickr,
            .openInIBooks,
            .assignToContact
        ]
        
        viewController.completionWithItemsHandler = { activity, isSuccess, activityItems, error in
            if isSuccess {
                self.listener?.didShareSuccess()
            } else {
                let alertController = UIAlertController(
                    title: "공유에 실패했습니다",
                    message: "다시 시도해주세요",
                    preferredStyle: .alert
                )
                
                let okAction = UIAlertAction(title: "확인", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
        }
        self.present(viewController, animated: true)
    }
}
